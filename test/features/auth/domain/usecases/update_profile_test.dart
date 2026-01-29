import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';
import 'package:running_mate/features/auth/domain/entities/running_goal.dart';
import 'package:running_mate/features/auth/domain/entities/user_profile.dart';
import 'package:running_mate/features/auth/domain/repositories/auth_repository.dart';
import 'package:running_mate/features/auth/domain/usecases/update_profile.dart';

import 'update_profile_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late UpdateProfile useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = UpdateProfile(mockRepository);
  });

  group('UpdateProfile', () {
    final baseProfile = UserProfile(
      id: 'user-123',
      email: 'test@example.com',
      provider: AuthProvider.google,
      createdAt: DateTime(2026, 1, 29),
    );

    test('should update nickname', () async {
      final updatedProfile = baseProfile.copyWith(nickname: '러너킴');
      when(mockRepository.updateProfile(any))
          .thenAnswer((_) async => updatedProfile);

      final result = await useCase(
        profile: baseProfile,
        nickname: '러너킴',
      );

      expect(result.nickname, '러너킴');
    });

    test('should update weight', () async {
      final updatedProfile = baseProfile.copyWith(weightKg: 70.5);
      when(mockRepository.updateProfile(any))
          .thenAnswer((_) async => updatedProfile);

      final result = await useCase(
        profile: baseProfile,
        weightKg: 70.5,
      );

      expect(result.weightKg, 70.5);
    });

    test('should update goal', () async {
      final updatedProfile = baseProfile.copyWith(goal: RunningGoal.marathon);
      when(mockRepository.updateProfile(any))
          .thenAnswer((_) async => updatedProfile);

      final result = await useCase(
        profile: baseProfile,
        goal: RunningGoal.marathon,
      );

      expect(result.goal, RunningGoal.marathon);
    });
  });
}
