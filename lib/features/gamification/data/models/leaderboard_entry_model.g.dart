// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardEntryModelImpl _$$LeaderboardEntryModelImplFromJson(
  Map<String, dynamic> json,
) => _$LeaderboardEntryModelImpl(
  userId: json['user_id'] as String,
  displayName: json['display_name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  totalDistance: (json['total_distance'] as num).toDouble(),
  runCount: (json['run_count'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
);

Map<String, dynamic> _$$LeaderboardEntryModelImplToJson(
  _$LeaderboardEntryModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'display_name': instance.displayName,
  'avatar_url': instance.avatarUrl,
  'total_distance': instance.totalDistance,
  'run_count': instance.runCount,
  'rank': instance.rank,
};
