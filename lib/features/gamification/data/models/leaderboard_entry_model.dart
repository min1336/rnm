// lib/features/gamification/data/models/leaderboard_entry_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leaderboard_entry.dart';

part 'leaderboard_entry_model.freezed.dart';
part 'leaderboard_entry_model.g.dart';

@freezed
class LeaderboardEntryModel with _$LeaderboardEntryModel {
  const LeaderboardEntryModel._();

  const factory LeaderboardEntryModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'total_distance') required double totalDistance,
    @JsonKey(name: 'run_count') required int runCount,
    required int rank,
  }) = _LeaderboardEntryModel;

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryModelFromJson(json);

  LeaderboardEntry toEntity() => LeaderboardEntry(
        userId: userId,
        displayName: displayName,
        avatarUrl: avatarUrl,
        totalDistance: totalDistance,
        runCount: runCount,
        rank: rank,
      );
}
