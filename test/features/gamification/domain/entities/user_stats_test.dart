import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_stats.dart';

void main() {
  group('UserStats', () {
    test('should create stats for achievement checking', () {
      final stats = UserStats(
        totalRuns: 10,
        totalDistanceKm: 45.5,
        currentStreak: 3,
        uniqueCourseCount: 5,
        sharedCourseCount: 1,
        earlyRunCount: 2,
        nightRunCount: 3,
        weekendStreak: 2,
      );

      expect(stats.totalRuns, 10);
      expect(stats.totalDistanceKm, 45.5);
      expect(stats.currentStreak, 3);
      expect(stats.uniqueCourseCount, 5);
      expect(stats.sharedCourseCount, 1);
      expect(stats.earlyRunCount, 2);
      expect(stats.nightRunCount, 3);
      expect(stats.weekendStreak, 2);
    });

    test('should support equality comparison', () {
      final stats1 = UserStats(
        totalRuns: 10,
        totalDistanceKm: 45.5,
        currentStreak: 3,
        uniqueCourseCount: 5,
        sharedCourseCount: 1,
        earlyRunCount: 2,
        nightRunCount: 3,
        weekendStreak: 2,
      );

      final stats2 = UserStats(
        totalRuns: 10,
        totalDistanceKm: 45.5,
        currentStreak: 3,
        uniqueCourseCount: 5,
        sharedCourseCount: 1,
        earlyRunCount: 2,
        nightRunCount: 3,
        weekendStreak: 2,
      );

      expect(stats1, stats2);
    });

    test('should detect different stats', () {
      final stats1 = UserStats(
        totalRuns: 10,
        totalDistanceKm: 45.5,
        currentStreak: 3,
        uniqueCourseCount: 5,
        sharedCourseCount: 1,
        earlyRunCount: 2,
        nightRunCount: 3,
        weekendStreak: 2,
      );

      final stats2 = UserStats(
        totalRuns: 11,
        totalDistanceKm: 45.5,
        currentStreak: 3,
        uniqueCourseCount: 5,
        sharedCourseCount: 1,
        earlyRunCount: 2,
        nightRunCount: 3,
        weekendStreak: 2,
      );

      expect(stats1, isNot(stats2));
    });
  });
}
