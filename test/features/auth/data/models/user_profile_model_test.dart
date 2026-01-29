import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/data/models/user_profile_model.dart';
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';
import 'package:running_mate/features/auth/domain/entities/running_goal.dart';

void main() {
  group('UserProfileModel', () {
    final testJson = {
      'id': 'user-123',
      'email': 'test@example.com',
      'nickname': '러너킴',
      'avatar_url': 'https://example.com/avatar.jpg',
      'weight_kg': 70.5,
      'goal': 'marathon',
      'provider': 'google',
      'created_at': '2026-01-29T00:00:00.000Z',
      'last_login_at': '2026-01-29T12:00:00.000Z',
      'is_deleted': false,
      'deletion_requested_at': null,
    };

    test('should parse from JSON correctly', () {
      final model = UserProfileModel.fromJson(testJson);

      expect(model.id, 'user-123');
      expect(model.email, 'test@example.com');
      expect(model.nickname, '러너킴');
      expect(model.avatarUrl, 'https://example.com/avatar.jpg');
      expect(model.weightKg, 70.5);
      expect(model.goal, 'marathon');
      expect(model.provider, 'google');
    });

    test('should convert to entity correctly', () {
      final model = UserProfileModel.fromJson(testJson);
      final entity = model.toEntity();

      expect(entity.id, 'user-123');
      expect(entity.nickname, '러너킴');
      expect(entity.provider, AuthProvider.google);
      expect(entity.goal, RunningGoal.marathon);
    });

    test('should convert to JSON correctly', () {
      final model = UserProfileModel.fromJson(testJson);
      final json = model.toJson();

      expect(json['id'], 'user-123');
      expect(json['nickname'], '러너킴');
      expect(json['weight_kg'], 70.5);
    });

    test('should create from entity', () {
      final model = UserProfileModel.fromEntity(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴',
        weightKg: 70.5,
        goal: RunningGoal.marathon,
      );

      expect(model.id, 'user-123');
      expect(model.nickname, '러너킴');
      expect(model.goal, 'marathon');
    });
  });
}
