import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_streak.dart';

void main() {
  group('UserStreak', () {
    test('should create streak with current and longest', () {
      final streak = UserStreak(
        userId: 'user-1',
        currentStreak: 5,
        longestStreak: 10,
        lastRunDate: DateTime(2026, 1, 29),
        updatedAt: DateTime.now(),
      );

      expect(streak.currentStreak, 5);
      expect(streak.longestStreak, 10);
    });

    test('should allow null lastRunDate for new users', () {
      final streak = UserStreak(
        userId: 'user-1',
        currentStreak: 0,
        longestStreak: 0,
        lastRunDate: null,
        updatedAt: DateTime.now(),
      );

      expect(streak.lastRunDate, isNull);
      expect(streak.currentStreak, 0);
    });
  });
}
