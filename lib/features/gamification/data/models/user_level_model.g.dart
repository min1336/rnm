// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserLevelModelImpl _$$UserLevelModelImplFromJson(Map<String, dynamic> json) =>
    _$UserLevelModelImpl(
      userId: json['user_id'] as String,
      currentXp: (json['current_xp'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$UserLevelModelImplToJson(
  _$UserLevelModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'current_xp': instance.currentXp,
  'level': instance.level,
  'updated_at': instance.updatedAt,
};
