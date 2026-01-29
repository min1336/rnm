// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_streak_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStreakModelImpl _$$UserStreakModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserStreakModelImpl(
  userId: json['user_id'] as String,
  currentStreak: (json['current_streak'] as num).toInt(),
  longestStreak: (json['longest_streak'] as num).toInt(),
  lastRunDate: json['last_run_date'] as String?,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$$UserStreakModelImplToJson(
  _$UserStreakModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'current_streak': instance.currentStreak,
  'longest_streak': instance.longestStreak,
  'last_run_date': instance.lastRunDate,
  'updated_at': instance.updatedAt,
};
