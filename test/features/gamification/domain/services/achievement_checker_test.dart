import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_stats.dart';
import 'package:running_mate/features/gamification/domain/services/achievement_checker.dart';
import 'package:running_mate/features/gamification/domain/services/achievement_definitions.dart';

void main() {
  late AchievementChecker checker;

  setUp(() {
    checker = AchievementChecker(allAchievements);
  });

  group('AchievementChecker', () {
    test('should unlock first_step on first run', () {
      final stats = UserStats(
        totalRuns: 1,
        totalDistanceKm: 3.0,
        currentStreak: 1,
        uniqueCourseCount: 0,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {},
      );

      expect(newAchievements.any((a) => a.id == 'first_step'), true);
    });

    test('should unlock runner_5k when total distance >= 5km', () {
      final stats = UserStats(
        totalRuns: 2,
        totalDistanceKm: 5.5,
        currentStreak: 2,
        uniqueCourseCount: 1,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {'first_step'},
      );

      expect(newAchievements.any((a) => a.id == 'runner_5k'), true);
    });

    test('should unlock streak_3 when current streak >= 3', () {
      final stats = UserStats(
        totalRuns: 3,
        totalDistanceKm: 10.0,
        currentStreak: 3,
        uniqueCourseCount: 1,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {'first_step', 'runner_5k'},
      );

      expect(newAchievements.any((a) => a.id == 'streak_3'), true);
    });

    test('should unlock pace_breaker_6 when pace <= 6:00', () {
      final stats = UserStats(
        totalRuns: 5,
        totalDistanceKm: 20.0,
        currentStreak: 1,
        uniqueCourseCount: 2,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 5.0,
        runPaceMinPerKm: 5.5,
        unlockedIds: {'first_step', 'runner_5k'},
      );

      expect(newAchievements.any((a) => a.id == 'pace_breaker_6'), true);
    });

    test('should not unlock already unlocked achievement', () {
      final stats = UserStats(
        totalRuns: 1,
        totalDistanceKm: 3.0,
        currentStreak: 1,
        uniqueCourseCount: 0,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {'first_step'},
      );

      expect(newAchievements.any((a) => a.id == 'first_step'), false);
    });

    test('should unlock long_runner for single run >= 10km', () {
      final stats = UserStats(
        totalRuns: 5,
        totalDistanceKm: 25.0,
        currentStreak: 1,
        uniqueCourseCount: 2,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 10.5,
        runPaceMinPerKm: 6.0,
        unlockedIds: {'first_step'},
      );

      expect(newAchievements.any((a) => a.id == 'long_runner'), true);
    });
  });
}
