import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/gamification_remote_datasource.dart';
import '../../data/repositories/gamification_repository_impl.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/user_level.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../../domain/usecases/process_run_completion.dart';

// Data Sources
final gamificationDataSourceProvider =
    Provider<GamificationRemoteDataSource>((ref) {
  return GamificationRemoteDataSource(Supabase.instance.client);
});

// Repositories
final gamificationRepositoryProvider = Provider<GamificationRepository>((ref) {
  return GamificationRepositoryImpl(ref.watch(gamificationDataSourceProvider));
});

// Use Cases
final processRunCompletionProvider = Provider<ProcessRunCompletion>((ref) {
  return ProcessRunCompletion(
    repository: ref.watch(gamificationRepositoryProvider),
  );
});

// State - User Level
final userLevelProvider =
    FutureProvider.autoDispose.family<UserLevel, String>((ref, userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserLevel(userId);
});

// State - User Achievements
final userAchievementsProvider = FutureProvider.autoDispose
    .family<List<UserAchievement>, String>((ref, userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserAchievements(userId);
});

// State - All Achievements
final allAchievementsProvider =
    FutureProvider.autoDispose<List<Achievement>>((ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getAllAchievements();
});

// State - Active Challenges
final activeChallengesProvider =
    FutureProvider.autoDispose<List<Challenge>>((ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getActiveChallenges();
});

// State - User Challenges
final userChallengesProvider = FutureProvider.autoDispose
    .family<List<UserChallenge>, String>((ref, userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserChallenges(userId);
});

// State - Weekly Leaderboard
final weeklyLeaderboardProvider =
    FutureProvider.autoDispose<List<LeaderboardEntry>>((ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getLeaderboard(LeaderboardType.weeklyDistance);
});

// State - Monthly Leaderboard
final monthlyLeaderboardProvider =
    FutureProvider.autoDispose<List<LeaderboardEntry>>((ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getLeaderboard(LeaderboardType.monthlyDistance);
});

// State - User Weekly Rank
final userWeeklyRankProvider = FutureProvider.autoDispose
    .family<LeaderboardEntry?, String>((ref, userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserRank(userId, LeaderboardType.weeklyDistance);
});
