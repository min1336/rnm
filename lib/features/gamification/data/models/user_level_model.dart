// lib/features/gamification/data/models/user_level_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_level.dart';

part 'user_level_model.freezed.dart';
part 'user_level_model.g.dart';

@freezed
class UserLevelModel with _$UserLevelModel {
  const UserLevelModel._();

  const factory UserLevelModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'current_xp') required int currentXp,
    required int level,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _UserLevelModel;

  factory UserLevelModel.fromJson(Map<String, dynamic> json) =>
      _$UserLevelModelFromJson(json);

  UserLevel toEntity() => UserLevel(
        userId: userId,
        currentXp: currentXp,
        level: level,
        updatedAt: DateTime.parse(updatedAt),
      );
}
