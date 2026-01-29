import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';
import 'package:running_mate/features/course/domain/services/course_scorer.dart';

void main() {
  late CourseScorer scorer;

  setUp(() {
    scorer = CourseScorer();
  });

  group('CourseScorer', () {
    final testCourse = Course(
      id: '1',
      name: '테스트 코스',
      routePoints: [LatLng(37.5, 127.0)],
      distanceKm: 3.0,
      estimatedMinutes: 18,
      difficulty: 3,
      isOfficial: true,
      averageRating: 4.0,
      totalRuns: 100,
      createdAt: DateTime.now(),
    );

    final testProfile = UserRunningProfile(
      userId: 'user-1',
      averagePaceMinPerKm: 6.0,
      averageDistanceKm: 5.0,
      weeklyRunCount: 3,
      calculatedLevel: 3,
      lastRunAt: DateTime.now(),
      levelUpdatedAt: DateTime.now(),
    );

    test('should return 100 for distance score when course is within 1km', () {
      final score = scorer.calculateDistanceScore(
        courseStartLat: 37.5,
        courseStartLng: 127.0,
        userLat: 37.5,
        userLng: 127.0,
      );

      expect(score, 100);
    });

    test('should return 0 for distance score when course is 10km+ away', () {
      final score = scorer.calculateDistanceScore(
        courseStartLat: 37.5,
        courseStartLng: 127.0,
        userLat: 37.6, // 약 11km 떨어진 위치
        userLng: 127.0,
      );

      expect(score, lessThanOrEqualTo(10));
    });

    test('should return 100 for difficulty score when level matches exactly', () {
      final score = scorer.calculateDifficultyScore(
        courseDifficulty: 3,
        userLevel: 3,
      );

      expect(score, 100);
    });

    test('should return 70 for difficulty score when 1 level difference', () {
      final score = scorer.calculateDifficultyScore(
        courseDifficulty: 4,
        userLevel: 3,
      );

      expect(score, 70);
    });

    test('should return 80 (average) for popularity score with 4.0 rating', () {
      final score = scorer.calculatePopularityScore(averageRating: 4.0);

      expect(score, 80);
    });

    test('should calculate total score with weights', () {
      final result = scorer.score(
        course: testCourse,
        profile: testProfile,
        userLat: 37.5,
        userLng: 127.0,
        weights: RunningContext.defaultMode.weights,
      );

      expect(result.totalScore, greaterThan(0));
      expect(result.totalScore, lessThanOrEqualTo(100));
      expect(result.reason, isNotEmpty);
    });
  });
}
