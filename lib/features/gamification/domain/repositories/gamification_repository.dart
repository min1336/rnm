import '../entities/achievement.dart';
import '../entities/challenge.dart';
import '../entities/leaderboard_entry.dart';
import '../entities/user_level.dart';
import '../entities/user_stats.dart';
import '../entities/user_streak.dart';

abstract class GamificationRepository {
  // Level
  Future<UserLevel> getUserLevel(String userId);
  Future<UserLevel> addXp(String userId, int xp);

  // Streak
  Future<UserStreak> getUserStreak(String userId);
  Future<void> saveUserStreak(UserStreak streak);

  // Achievements
  Future<List<Achievement>> getAllAchievements();
  Future<Set<String>> getUnlockedAchievementIds(String userId);
  Future<List<UserAchievement>> getUserAchievements(String userId);
  Future<void> unlockAchievement(String userId, String achievementId);

  // Stats
  Future<UserStats> getUserStats(String userId);
  Future<bool> isFirstCourseCompletion(String userId, String courseId);

  // Challenges
  Future<List<Challenge>> getActiveChallenges();
  Future<List<UserChallenge>> getUserChallenges(String userId);
  Future<void> joinChallenge(String userId, String challengeId);
  Future<List<UserChallenge>> updateChallengeProgress(
    String userId,
    double distanceKm,
    int durationMinutes,
    String? courseId,
  );

  // Leaderboard
  Future<List<LeaderboardEntry>> getLeaderboard(LeaderboardType type, {int limit = 100});
  Future<LeaderboardEntry?> getUserRank(String userId, LeaderboardType type);
}
