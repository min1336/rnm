import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';
import 'package:running_mate/features/course/domain/services/context_detector.dart';
import 'package:running_mate/features/course/domain/services/course_scorer.dart';
import 'package:running_mate/features/course/domain/services/recommendation_engine.dart';

void main() {
  late RecommendationEngine engine;

  setUp(() {
    engine = RecommendationEngine(
      contextDetector: ContextDetector(),
      courseScorer: CourseScorer(),
    );
  });

  group('RecommendationEngine', () {
    final courses = [
      Course(
        id: '1',
        name: '가까운 쉬운 코스',
        routePoints: [LatLng(37.5, 127.0)],
        distanceKm: 2.0,
        estimatedMinutes: 12,
        difficulty: 1,
        isOfficial: true,
        averageRating: 3.5,
        totalRuns: 50,
        createdAt: DateTime.now(),
      ),
      Course(
        id: '2',
        name: '먼 어려운 코스',
        routePoints: [LatLng(37.6, 127.1)],
        distanceKm: 10.0,
        estimatedMinutes: 60,
        difficulty: 5,
        isOfficial: true,
        averageRating: 4.8,
        totalRuns: 200,
        createdAt: DateTime.now(),
      ),
      Course(
        id: '3',
        name: '적절한 코스',
        routePoints: [LatLng(37.51, 127.01)],
        distanceKm: 5.0,
        estimatedMinutes: 30,
        difficulty: 3,
        isOfficial: true,
        averageRating: 4.5,
        totalRuns: 150,
        createdAt: DateTime.now(),
      ),
    ];

    final profile = UserRunningProfile(
      userId: 'user-1',
      averagePaceMinPerKm: 6.0,
      averageDistanceKm: 5.0,
      weeklyRunCount: 3,
      calculatedLevel: 3,
      lastRunAt: DateTime.now().subtract(const Duration(days: 1)),
      levelUpdatedAt: DateTime.now(),
    );

    test('should return courses sorted by score', () {
      final result = engine.recommend(
        courses: courses,
        profile: profile,
        userLat: 37.5,
        userLng: 127.0,
        context: RunningContext.defaultMode,
      );

      expect(result.length, 3);
      // 점수 순 정렬 확인
      for (int i = 0; i < result.length - 1; i++) {
        expect(result[i].totalScore, greaterThanOrEqualTo(result[i + 1].totalScore));
      }
    });

    test('should limit results to specified count', () {
      final result = engine.recommend(
        courses: courses,
        profile: profile,
        userLat: 37.5,
        userLng: 127.0,
        context: RunningContext.defaultMode,
        limit: 2,
      );

      expect(result.length, 2);
    });

    test('quick mode should favor nearby courses over far courses', () {
      final quickResult = engine.recommend(
        courses: courses,
        profile: profile,
        userLat: 37.5,
        userLng: 127.0,
        context: RunningContext.quick,
      );

      // 빠른 모드에서는 먼 코스(id=2)가 마지막에 위치해야 함
      expect(quickResult.last.course.id, '2'); // 가장 먼 코스
    });
  });
}
