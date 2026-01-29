// lib/features/gamification/domain/usecases/process_run_completion.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/achievement.dart';
import '../entities/challenge.dart';
import '../repositories/gamification_repository.dart';
import '../services/achievement_checker.dart';
import '../services/achievement_definitions.dart';
import '../services/streak_calculator.dart';
import '../services/xp_calculator.dart';

part 'process_run_completion.freezed.dart';

@freezed
class RunCompletionResult with _$RunCompletionResult {
  const factory RunCompletionResult({
    required int earnedXp,
    required List<Achievement> newAchievements,
    required bool leveledUp,
    required int newLevel,
    required int previousLevel,
    required int currentStreak,
    required List<UserChallenge> completedChallenges,
  }) = _RunCompletionResult;
}

class ProcessRunCompletion {
  final GamificationRepository repository;
  final XpCalculator xpCalculator;
  final AchievementChecker achievementChecker;
  final StreakCalculator streakCalculator;

  ProcessRunCompletion({
    required this.repository,
    XpCalculator? xpCalculator,
    AchievementChecker? achievementChecker,
    StreakCalculator? streakCalculator,
  })  : xpCalculator = xpCalculator ?? XpCalculator(),
        achievementChecker = achievementChecker ?? AchievementChecker(allAchievements),
        streakCalculator = streakCalculator ?? StreakCalculator();

  Future<RunCompletionResult> execute({
    required String userId,
    required double distanceKm,
    required int durationMinutes,
    required double paceMinPerKm,
    required DateTime runAt,
    String? courseId,
  }) async {
    // 1. 기본 XP 계산
    int earnedXp = xpCalculator.calculateRunXp(distanceKm: distanceKm);

    // 2. 코스 첫 완주 보너스
    if (courseId != null) {
      final isFirstTime = await repository.isFirstCourseCompletion(
        userId,
        courseId,
      );
      if (isFirstTime) {
        earnedXp += xpCalculator.firstCourseBonus;
      }
    }

    // 3. 스트릭 업데이트
    final currentStreak = await repository.getUserStreak(userId);
    final newStreak = streakCalculator.updateStreak(currentStreak, runAt);
    await repository.saveUserStreak(newStreak);

    // 4. 사용자 통계 조회
    final stats = await repository.getUserStats(userId);
    final unlockedIds = await repository.getUnlockedAchievementIds(userId);

    // 5. 업적 체크
    final statsWithStreak = stats.copyWith(currentStreak: newStreak.currentStreak);
    final newAchievements = achievementChecker.checkAfterRun(
      stats: statsWithStreak,
      runDistanceKm: distanceKm,
      runPaceMinPerKm: paceMinPerKm,
      unlockedIds: unlockedIds,
    );

    // 6. 업적 저장 및 XP 추가
    for (final achievement in newAchievements) {
      earnedXp += achievement.xpReward;
      await repository.unlockAchievement(userId, achievement.id);
    }

    // 7. XP 적용 및 레벨업 체크
    final previousLevel = await repository.getUserLevel(userId);
    final newLevelData = await repository.addXp(userId, earnedXp);
    final leveledUp = newLevelData.level > previousLevel.level;

    // 8. 챌린지 진행률 업데이트
    final updatedChallenges = await repository.updateChallengeProgress(
      userId,
      distanceKm,
      durationMinutes,
      courseId,
    );

    // 완료된 챌린지 XP 추가
    for (final uc in updatedChallenges.where((c) => c.isCompleted)) {
      await repository.addXp(userId, uc.challenge.xpReward);
      earnedXp += uc.challenge.xpReward;
    }

    return RunCompletionResult(
      earnedXp: earnedXp,
      newAchievements: newAchievements,
      leveledUp: leveledUp,
      newLevel: newLevelData.level,
      previousLevel: previousLevel.level,
      currentStreak: newStreak.currentStreak,
      completedChallenges: updatedChallenges.where((c) => c.isCompleted).toList(),
    );
  }
}
