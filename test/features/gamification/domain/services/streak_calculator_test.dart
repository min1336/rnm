import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_streak.dart';
import 'package:running_mate/features/gamification/domain/services/streak_calculator.dart';

void main() {
  late StreakCalculator calculator;

  setUp(() {
    calculator = StreakCalculator();
  });

  group('StreakCalculator', () {
    test('should start streak at 1 for first run', () {
      final current = UserStreak(
        userId: 'user-1',
        currentStreak: 0,
        longestStreak: 0,
        lastRunDate: null,
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),  // KST
      );

      expect(result.currentStreak, 1);
      expect(result.longestStreak, 1);
    });

    test('should increment streak for consecutive day', () {
      final current = UserStreak(
        userId: 'user-1',
        currentStreak: 3,
        longestStreak: 5,
        lastRunDate: DateTime(2026, 1, 28),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),
      );

      expect(result.currentStreak, 4);
      expect(result.longestStreak, 5);
    });

    test('should reset streak when gap is more than 1 day', () {
      final current = UserStreak(
        userId: 'user-1',
        currentStreak: 5,
        longestStreak: 10,
        lastRunDate: DateTime(2026, 1, 26),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),
      );

      expect(result.currentStreak, 1);
      expect(result.longestStreak, 10);
    });

    test('should not change streak for same day run', () {
      final current = UserStreak(
        userId: 'user-1',
        currentStreak: 3,
        longestStreak: 5,
        lastRunDate: DateTime(2026, 1, 29),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 18, 0),
      );

      expect(result.currentStreak, 3);
    });

    test('should update longest streak when current exceeds', () {
      final current = UserStreak(
        userId: 'user-1',
        currentStreak: 9,
        longestStreak: 9,
        lastRunDate: DateTime(2026, 1, 28),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),
      );

      expect(result.currentStreak, 10);
      expect(result.longestStreak, 10);
    });
  });
}
