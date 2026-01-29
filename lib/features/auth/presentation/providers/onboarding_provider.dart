import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/running_goal.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/validate_nickname.dart';
import 'auth_providers.dart';

part 'onboarding_provider.freezed.dart';
part 'onboarding_provider.g.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentStep,
    String? nickname,
    double? weightKg,
    RunningGoal? goal,
    @Default(false) bool isLoading,
    String? error,
  }) = _OnboardingState;
}

@riverpod
class Onboarding extends _$Onboarding {
  late ValidateNickname _validateNickname;

  @override
  OnboardingState build() {
    final repository = ref.watch(authRepositoryProvider);
    _validateNickname = ValidateNickname(repository);
    return const OnboardingState();
  }

  Future<NicknameValidationResult> validateNickname(String nickname) {
    return _validateNickname(nickname);
  }

  Future<void> setNickname(String nickname) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await validateNickname(nickname);
    if (result != NicknameValidationResult.valid) {
      state = state.copyWith(
        isLoading: false,
        error: _getErrorMessage(result),
      );
      return;
    }

    state = state.copyWith(
      nickname: nickname,
      currentStep: 1,
      isLoading: false,
    );
  }

  void setWeight(double? weight) {
    state = state.copyWith(
      weightKg: weight,
      currentStep: 2,
    );
  }

  void setGoal(RunningGoal? goal) {
    state = state.copyWith(goal: goal);
  }

  void skipWeight() {
    state = state.copyWith(currentStep: 2);
  }

  void goBack() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<UserProfile> completeOnboarding() async {
    state = state.copyWith(isLoading: true);

    final repository = ref.read(authRepositoryProvider);
    final currentUser = ref.read(currentUserProvider);

    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    final updatedProfile = currentUser.copyWith(
      nickname: state.nickname,
      weightKg: state.weightKg,
      goal: state.goal,
    );

    final result = await repository.updateProfile(updatedProfile);

    ref.read(authStateNotifierProvider.notifier).completeOnboarding(result);
    state = state.copyWith(isLoading: false);

    return result;
  }

  String _getErrorMessage(NicknameValidationResult result) {
    return switch (result) {
      NicknameValidationResult.empty => '닉네임을 입력해주세요',
      NicknameValidationResult.tooShort => '닉네임은 2자 이상이어야 해요',
      NicknameValidationResult.tooLong => '닉네임은 10자 이하여야 해요',
      NicknameValidationResult.invalidCharacters => '한글, 영문, 숫자만 사용할 수 있어요',
      NicknameValidationResult.duplicate => '이미 사용 중인 닉네임이에요',
      NicknameValidationResult.valid => '',
    };
  }
}
