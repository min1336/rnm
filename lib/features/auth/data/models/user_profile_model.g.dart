// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileModelImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  nickname: json['nickname'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  weightKg: (json['weight_kg'] as num?)?.toDouble(),
  goal: json['goal'] as String?,
  provider: json['provider'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  lastLoginAt: json['last_login_at'] == null
      ? null
      : DateTime.parse(json['last_login_at'] as String),
  isDeleted: json['is_deleted'] as bool? ?? false,
  deletionRequestedAt: json['deletion_requested_at'] == null
      ? null
      : DateTime.parse(json['deletion_requested_at'] as String),
);

Map<String, dynamic> _$$UserProfileModelImplToJson(
  _$UserProfileModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'nickname': instance.nickname,
  'avatar_url': instance.avatarUrl,
  'weight_kg': instance.weightKg,
  'goal': instance.goal,
  'provider': instance.provider,
  'created_at': instance.createdAt.toIso8601String(),
  'last_login_at': instance.lastLoginAt?.toIso8601String(),
  'is_deleted': instance.isDeleted,
  'deletion_requested_at': instance.deletionRequestedAt?.toIso8601String(),
};
