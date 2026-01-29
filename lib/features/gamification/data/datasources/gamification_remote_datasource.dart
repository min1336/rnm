// lib/features/gamification/data/datasources/gamification_remote_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/challenge_model.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/user_level_model.dart';
import '../models/user_streak_model.dart';

class GamificationRemoteDataSource {
  final SupabaseClient _client;

  GamificationRemoteDataSource(this._client);

  // Level
  Future<UserLevelModel?> getUserLevel(String userId) async {
    final response = await _client
        .from('user_levels')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (response == null) return null;
    return UserLevelModel.fromJson(response);
  }

  Future<UserLevelModel> upsertUserLevel({
    required String userId,
    required int currentXp,
    required int level,
  }) async {
    final response = await _client
        .from('user_levels')
        .upsert({
          'user_id': userId,
          'current_xp': currentXp,
          'level': level,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();
    return UserLevelModel.fromJson(response);
  }

  // Streak
  Future<UserStreakModel?> getUserStreak(String userId) async {
    final response = await _client
        .from('user_streaks')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (response == null) return null;
    return UserStreakModel.fromJson(response);
  }

  Future<void> upsertUserStreak(UserStreakModel streak) async {
    await _client.from('user_streaks').upsert(streak.toJson());
  }

  // Achievements
  Future<List<Map<String, dynamic>>> getAllAchievements() async {
    final response = await _client.from('achievements').select();
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<String>> getUnlockedAchievementIds(String userId) async {
    final response = await _client
        .from('user_achievements')
        .select('achievement_id')
        .eq('user_id', userId);
    return (response as List).map((r) => r['achievement_id'] as String).toList();
  }

  Future<List<Map<String, dynamic>>> getUserAchievements(String userId) async {
    final response = await _client
        .from('user_achievements')
        .select('*, achievement:achievements(*)')
        .eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> insertUserAchievement(String userId, String achievementId) async {
    await _client.from('user_achievements').insert({
      'user_id': userId,
      'achievement_id': achievementId,
    });
  }

  // Stats
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    // 여러 쿼리를 조합하여 통계 생성
    final totalRuns = await _client
        .from('run_histories')
        .select()
        .eq('user_id', userId)
        .count(CountOption.exact);

    final distanceResult = await _client
        .from('run_histories')
        .select('distance_km')
        .eq('user_id', userId);

    final totalDistance = (distanceResult as List)
        .fold<double>(0, (sum, r) => sum + (r['distance_km'] as num).toDouble());

    final uniqueCourses = await _client
        .from('run_histories')
        .select('course_id')
        .eq('user_id', userId)
        .not('course_id', 'is', null);

    final uniqueCourseIds = (uniqueCourses as List)
        .map((r) => r['course_id'])
        .toSet();

    final sharedCourses = await _client
        .from('courses')
        .select()
        .eq('creator_id', userId)
        .count(CountOption.exact);

    final streakData = await getUserStreak(userId);

    return {
      'total_runs': totalRuns.count,
      'total_distance_km': totalDistance,
      'current_streak': streakData?.currentStreak ?? 0,
      'unique_course_count': uniqueCourseIds.length,
      'shared_course_count': sharedCourses.count,
      'early_run_count': 0,  // 별도 계산 필요 (시간대 기반)
      'night_run_count': 0,  // 별도 계산 필요 (시간대 기반)
      'weekend_streak': 0,   // 별도 계산 필요
    };
  }

  Future<bool> isFirstCourseCompletion(String userId, String courseId) async {
    final response = await _client
        .from('run_histories')
        .select()
        .eq('user_id', userId)
        .eq('course_id', courseId)
        .count(CountOption.exact);
    return response.count == 1;
  }

  // Challenges
  Future<List<ChallengeModel>> getActiveChallenges() async {
    final now = DateTime.now().toIso8601String();
    final response = await _client
        .from('challenges')
        .select()
        .eq('is_active', true)
        .lte('start_at', now)
        .gte('end_at', now);
    return (response as List).map((j) => ChallengeModel.fromJson(j)).toList();
  }

  Future<List<UserChallengeModel>> getUserChallenges(String userId) async {
    final response = await _client
        .from('user_challenges')
        .select('*, challenge:challenges(*)')
        .eq('user_id', userId);
    return (response as List).map((j) => UserChallengeModel.fromJson({
      ...j,
      'challenge': j['challenge'],
    })).toList();
  }

  Future<void> joinChallenge(String userId, String challengeId) async {
    await _client.from('user_challenges').insert({
      'user_id': userId,
      'challenge_id': challengeId,
    });
  }

  Future<void> updateChallengeProgress({
    required String userId,
    required String challengeId,
    required int progress,
    required bool isCompleted,
  }) async {
    await _client.from('user_challenges').update({
      'current_progress': progress,
      'is_completed': isCompleted,
      'completed_at': isCompleted ? DateTime.now().toIso8601String() : null,
    }).eq('user_id', userId).eq('challenge_id', challengeId);
  }

  // Leaderboard
  Future<List<LeaderboardEntryModel>> getWeeklyLeaderboard({int limit = 100}) async {
    final response = await _client
        .from('weekly_distance_leaderboard')
        .select()
        .limit(limit);
    return (response as List).map((j) => LeaderboardEntryModel.fromJson(j)).toList();
  }

  Future<List<LeaderboardEntryModel>> getMonthlyLeaderboard({int limit = 100}) async {
    final response = await _client
        .from('monthly_distance_leaderboard')
        .select()
        .limit(limit);
    return (response as List).map((j) => LeaderboardEntryModel.fromJson(j)).toList();
  }

  Future<LeaderboardEntryModel?> getUserWeeklyRank(String userId) async {
    final response = await _client
        .from('weekly_distance_leaderboard')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (response == null) return null;
    return LeaderboardEntryModel.fromJson(response);
  }

  Future<LeaderboardEntryModel?> getUserMonthlyRank(String userId) async {
    final response = await _client
        .from('monthly_distance_leaderboard')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (response == null) return null;
    return LeaderboardEntryModel.fromJson(response);
  }
}
