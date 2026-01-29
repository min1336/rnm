import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entry.freezed.dart';

enum LeaderboardType { weeklyDistance, monthlyDistance }

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String userId,
    required String displayName,
    String? avatarUrl,
    required double totalDistance,
    required int runCount,
    required int rank,
  }) = _LeaderboardEntry;
}
