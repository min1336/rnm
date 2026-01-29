// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      targetValue: (json['target_value'] as num).toInt(),
      unit: json['unit'] as String,
      xpReward: (json['xp_reward'] as num).toInt(),
      startAt: json['start_at'] as String,
      endAt: json['end_at'] as String,
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
  _$ChallengeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'target_value': instance.targetValue,
  'unit': instance.unit,
  'xp_reward': instance.xpReward,
  'start_at': instance.startAt,
  'end_at': instance.endAt,
};

_$UserChallengeModelImpl _$$UserChallengeModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserChallengeModelImpl(
  userId: json['user_id'] as String,
  challengeId: json['challenge_id'] as String,
  challenge: ChallengeModel.fromJson(json['challenge'] as Map<String, dynamic>),
  currentProgress: (json['current_progress'] as num).toInt(),
  isCompleted: json['is_completed'] as bool,
  completedAt: json['completed_at'] as String?,
  joinedAt: json['joined_at'] as String,
);

Map<String, dynamic> _$$UserChallengeModelImplToJson(
  _$UserChallengeModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'challenge_id': instance.challengeId,
  'challenge': instance.challenge,
  'current_progress': instance.currentProgress,
  'is_completed': instance.isCompleted,
  'completed_at': instance.completedAt,
  'joined_at': instance.joinedAt,
};
