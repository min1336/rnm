import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_provider.dart';
import '../../domain/entities/running_goal.dart';
import '../../domain/entities/user_profile.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  const UserProfileModel._();

  const factory UserProfileModel({
    required String id,
    required String email,
    String? nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'weight_kg') double? weightKg,
    String? goal,
    required String provider,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    @JsonKey(name: 'deletion_requested_at') DateTime? deletionRequestedAt,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  factory UserProfileModel.fromEntity({
    required String id,
    required String email,
    required AuthProvider provider,
    required DateTime createdAt,
    String? nickname,
    String? avatarUrl,
    double? weightKg,
    RunningGoal? goal,
    DateTime? lastLoginAt,
    bool isDeleted = false,
    DateTime? deletionRequestedAt,
  }) {
    return UserProfileModel(
      id: id,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      weightKg: weightKg,
      goal: goal?.name,
      provider: provider.name,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
      isDeleted: isDeleted,
      deletionRequestedAt: deletionRequestedAt,
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      id: id,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      weightKg: weightKg,
      goal: goal != null ? RunningGoal.values.byName(goal!) : null,
      provider: AuthProvider.values.byName(provider),
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
      isDeleted: isDeleted,
      deletionRequestedAt: deletionRequestedAt,
    );
  }
}
