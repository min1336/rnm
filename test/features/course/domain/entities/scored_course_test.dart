import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/scored_course.dart';

void main() {
  group('ScoredCourse', () {
    test('should contain course with score and reason', () {
      final course = Course(
        id: '1',
        name: '테스트 코스',
        routePoints: [],
        distanceKm: 3.0,
        estimatedMinutes: 18,
        difficulty: 3,
        isOfficial: true,
        averageRating: 4.5,
        totalRuns: 100,
        createdAt: DateTime.now(),
      );

      final scoredCourse = ScoredCourse(
        course: course,
        totalScore: 85.5,
        reason: '집에서 가깝고 난이도가 적절해요',
      );

      expect(scoredCourse.totalScore, 85.5);
      expect(scoredCourse.reason, contains('가깝고'));
    });
  });
}
