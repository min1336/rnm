import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';

void main() {
  group('UserRunningProfile', () {
    test('should create profile with calculated level', () {
      final profile = UserRunningProfile(
        userId: 'user-1',
        averagePaceMinPerKm: 5.5,
        averageDistanceKm: 5.0,
        weeklyRunCount: 3,
        calculatedLevel: 3,
        lastRunAt: DateTime(2026, 1, 28),
        levelUpdatedAt: DateTime(2026, 1, 28),
      );

      expect(profile.calculatedLevel, 3);
      expect(profile.goal, isNull);
    });

    test('should support optional goal', () {
      final profile = UserRunningProfile(
        userId: 'user-1',
        averagePaceMinPerKm: 5.5,
        averageDistanceKm: 5.0,
        weeklyRunCount: 3,
        calculatedLevel: 3,
        goal: RunningGoal.marathon,
        lastRunAt: DateTime(2026, 1, 28),
        levelUpdatedAt: DateTime(2026, 1, 28),
      );

      expect(profile.goal, RunningGoal.marathon);
    });
  });
}
