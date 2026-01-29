// lib/features/gamification/data/repositories/gamification_repository_impl.dart
import '../../domain/entities/achievement.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/user_level.dart';
import '../../domain/entities/user_stats.dart';
import '../../domain/entities/user_streak.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../../domain/services/achievement_definitions.dart';
import '../../domain/services/level_calculator.dart';
import '../datasources/gamification_remote_datasource.dart';
import '../models/user_streak_model.dart';

class GamificationRepositoryImpl implements GamificationRepository {
  final GamificationRemoteDataSource _dataSource;

  GamificationRepositoryImpl(this._dataSource);

  @override
  Future<UserLevel> getUserLevel(String userId) async {
    final model = await _dataSource.getUserLevel(userId);
    if (model != null) return model.toEntity();

    // 새 사용자: 기본 레벨 생성
    final newModel = await _dataSource.upsertUserLevel(
      userId: userId,
      currentXp: 0,
      level: 1,
    );
    return newModel.toEntity();
  }

  @override
  Future<UserLevel> addXp(String userId, int xp) async {
    final current = await getUserLevel(userId);
    final newXp = current.currentXp + xp;
    final newLevel = LevelCalculator.getLevelForXp(newXp);

    final model = await _dataSource.upsertUserLevel(
      userId: userId,
      currentXp: newXp,
      level: newLevel,
    );
    return model.toEntity();
  }

  @override
  Future<UserStreak> getUserStreak(String userId) async {
    final model = await _dataSource.getUserStreak(userId);
    if (model != null) return model.toEntity();

    return UserStreak(
      userId: userId,
      currentStreak: 0,
      longestStreak: 0,
      lastRunDate: null,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> saveUserStreak(UserStreak streak) async {
    await _dataSource.upsertUserStreak(UserStreakModel.fromEntity(streak));
  }

  @override
  Future<List<Achievement>> getAllAchievements() async {
    return allAchievements;
  }

  @override
  Future<Set<String>> getUnlockedAchievementIds(String userId) async {
    final ids = await _dataSource.getUnlockedAchievementIds(userId);
    return ids.toSet();
  }

  @override
  Future<List<UserAchievement>> getUserAchievements(String userId) async {
    final data = await _dataSource.getUserAchievements(userId);
    return data.map((d) {
      final achievementData = d['achievement'] as Map<String, dynamic>;
      final achievement = allAchievements.firstWhere(
        (a) => a.id == achievementData['id'],
        orElse: () => Achievement(
          id: achievementData['id'],
          name: achievementData['name'] ?? '',
          description: achievementData['description'] ?? '',
          iconName: achievementData['icon_name'] ?? 'star',
          category: AchievementCategory.values.firstWhere(
            (c) => c.name == achievementData['category'],
            orElse: () => AchievementCategory.special,
          ),
          conditionType: ConditionType.values.firstWhere(
            (t) => t.name == achievementData['condition_type'],
            orElse: () => ConditionType.firstRun,
          ),
          conditionValue: achievementData['condition_value'] ?? 0,
          xpReward: achievementData['xp_reward'] ?? 0,
        ),
      );
      return UserAchievement(
        userId: d['user_id'],
        achievementId: d['achievement_id'],
        achievement: achievement,
        unlockedAt: DateTime.parse(d['unlocked_at']),
      );
    }).toList();
  }

  @override
  Future<void> unlockAchievement(String userId, String achievementId) async {
    await _dataSource.insertUserAchievement(userId, achievementId);
  }

  @override
  Future<UserStats> getUserStats(String userId) async {
    final data = await _dataSource.getUserStats(userId);
    return UserStats(
      totalRuns: data['total_runs'] ?? 0,
      totalDistanceKm: (data['total_distance_km'] as num?)?.toDouble() ?? 0,
      currentStreak: data['current_streak'] ?? 0,
      uniqueCourseCount: data['unique_course_count'] ?? 0,
      sharedCourseCount: data['shared_course_count'] ?? 0,
      earlyRunCount: data['early_run_count'] ?? 0,
      nightRunCount: data['night_run_count'] ?? 0,
      weekendStreak: data['weekend_streak'] ?? 0,
    );
  }

  @override
  Future<bool> isFirstCourseCompletion(String userId, String courseId) async {
    return _dataSource.isFirstCourseCompletion(userId, courseId);
  }

  @override
  Future<List<Challenge>> getActiveChallenges() async {
    final models = await _dataSource.getActiveChallenges();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<UserChallenge>> getUserChallenges(String userId) async {
    final models = await _dataSource.getUserChallenges(userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> joinChallenge(String userId, String challengeId) async {
    await _dataSource.joinChallenge(userId, challengeId);
  }

  @override
  Future<List<UserChallenge>> updateChallengeProgress(
    String userId,
    double distanceKm,
    int durationMinutes,
    String? courseId,
  ) async {
    final userChallenges = await getUserChallenges(userId);
    final updatedChallenges = <UserChallenge>[];

    for (final uc in userChallenges) {
      if (uc.isCompleted || uc.isExpired) continue;

      int progressDelta = 0;
      switch (uc.challenge.unit) {
        case 'km':
          progressDelta = distanceKm.round();
          break;
        case 'runs':
          progressDelta = 1;
          break;
        case 'minutes':
          progressDelta = durationMinutes;
          break;
        case 'courses':
          if (courseId != null) progressDelta = 1;
          break;
      }

      if (progressDelta > 0) {
        final newProgress = uc.currentProgress + progressDelta;
        final isCompleted = newProgress >= uc.challenge.targetValue;

        await _dataSource.updateChallengeProgress(
          userId: userId,
          challengeId: uc.challengeId,
          progress: newProgress,
          isCompleted: isCompleted,
        );

        updatedChallenges.add(uc.copyWith(
          currentProgress: newProgress,
          isCompleted: isCompleted,
          completedAt: isCompleted ? DateTime.now() : null,
        ));
      }
    }

    return updatedChallenges;
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboard(
    LeaderboardType type, {
    int limit = 100,
  }) async {
    final models = switch (type) {
      LeaderboardType.weeklyDistance =>
        await _dataSource.getWeeklyLeaderboard(limit: limit),
      LeaderboardType.monthlyDistance =>
        await _dataSource.getMonthlyLeaderboard(limit: limit),
    };
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<LeaderboardEntry?> getUserRank(
    String userId,
    LeaderboardType type,
  ) async {
    final model = switch (type) {
      LeaderboardType.weeklyDistance =>
        await _dataSource.getUserWeeklyRank(userId),
      LeaderboardType.monthlyDistance =>
        await _dataSource.getUserMonthlyRank(userId),
    };
    return model?.toEntity();
  }
}
