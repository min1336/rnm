import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/gamification_remote_datasource.dart';
import '../../data/repositories/gamification_repository_impl.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/user_level.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../../domain/usecases/process_run_completion.dart';

part 'gamification_providers.g.dart';

@riverpod
GamificationRemoteDataSource gamificationDataSource(GamificationDataSourceRef ref) {
  return GamificationRemoteDataSource(Supabase.instance.client);
}

@riverpod
GamificationRepository gamificationRepository(GamificationRepositoryRef ref) {
  final dataSource = ref.watch(gamificationDataSourceProvider);
  return GamificationRepositoryImpl(dataSource);
}

@riverpod
ProcessRunCompletion processRunCompletion(ProcessRunCompletionRef ref) {
  final repository = ref.watch(gamificationRepositoryProvider);
  return ProcessRunCompletion(repository: repository);
}

@riverpod
Future<UserLevel> userLevel(UserLevelRef ref, String userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserLevel(userId);
}

@riverpod
Future<List<UserAchievement>> userAchievements(UserAchievementsRef ref, String userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserAchievements(userId);
}

@riverpod
Future<List<Achievement>> allAchievements(AllAchievementsRef ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getAllAchievements();
}

@riverpod
Future<List<Challenge>> activeChallenges(ActiveChallengesRef ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getActiveChallenges();
}

@riverpod
Future<List<UserChallenge>> userChallenges(UserChallengesRef ref, String userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserChallenges(userId);
}

@riverpod
Future<List<LeaderboardEntry>> weeklyLeaderboard(WeeklyLeaderboardRef ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getLeaderboard(LeaderboardType.weeklyDistance);
}

@riverpod
Future<List<LeaderboardEntry>> monthlyLeaderboard(MonthlyLeaderboardRef ref) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getLeaderboard(LeaderboardType.monthlyDistance);
}

@riverpod
Future<LeaderboardEntry?> userWeeklyRank(UserWeeklyRankRef ref, String userId) async {
  final repository = ref.watch(gamificationRepositoryProvider);
  return repository.getUserRank(userId, LeaderboardType.weeklyDistance);
}
