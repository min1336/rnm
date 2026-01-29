import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/domain/entities/user_profile.dart';
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';
import 'package:running_mate/features/auth/domain/entities/running_goal.dart';

void main() {
  group('UserProfile', () {
    test('should create UserProfile with required fields', () {
      final profile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
      );

      expect(profile.id, 'user-123');
      expect(profile.email, 'test@example.com');
      expect(profile.provider, AuthProvider.google);
      expect(profile.nickname, isNull);
    });

    test('should create UserProfile with optional fields', () {
      final profile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.apple,
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴',
        avatarUrl: 'https://example.com/avatar.jpg',
        weightKg: 70.5,
        goal: RunningGoal.marathon,
      );

      expect(profile.nickname, '러너킴');
      expect(profile.weightKg, 70.5);
      expect(profile.goal, RunningGoal.marathon);
    });

    test('should have isProfileComplete getter', () {
      final incompleteProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
      );

      final completeProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴',
      );

      expect(incompleteProfile.isProfileComplete, false);
      expect(completeProfile.isProfileComplete, true);
    });

    test('should support deletion state', () {
      final deletedProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        isDeleted: true,
        deletionRequestedAt: DateTime(2026, 1, 29),
      );

      expect(deletedProfile.isDeleted, true);
      expect(deletedProfile.deletionRequestedAt, isNotNull);
    });
  });
}
