import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_provider.dart';
import 'running_goal.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String id,
    required String email,
    String? nickname,
    String? avatarUrl,
    double? weightKg,
    RunningGoal? goal,
    required AuthProvider provider,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    @Default(false) bool isDeleted,
    DateTime? deletionRequestedAt,
  }) = _UserProfile;

  bool get isProfileComplete => nickname != null && nickname!.isNotEmpty;
}
