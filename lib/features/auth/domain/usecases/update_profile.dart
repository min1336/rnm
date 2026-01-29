import '../entities/running_goal.dart';
import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class UpdateProfile {
  final AuthRepository _repository;

  UpdateProfile(this._repository);

  Future<UserProfile> call({
    required UserProfile profile,
    String? nickname,
    double? weightKg,
    RunningGoal? goal,
  }) {
    final updatedProfile = profile.copyWith(
      nickname: nickname ?? profile.nickname,
      weightKg: weightKg ?? profile.weightKg,
      goal: goal ?? profile.goal,
    );
    return _repository.updateProfile(updatedProfile);
  }
}
