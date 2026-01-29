import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';

void main() {
  group('Course', () {
    test('should create Course with required fields', () {
      final course = Course(
        id: '1',
        name: '한강 여의도 코스',
        routePoints: [
          LatLng(37.5283, 126.9322),
          LatLng(37.5290, 126.9350),
        ],
        distanceKm: 3.2,
        estimatedMinutes: 20,
        difficulty: 3,
        isOfficial: true,
        averageRating: 4.5,
        totalRuns: 150,
        createdAt: DateTime(2026, 1, 1),
      );

      expect(course.id, '1');
      expect(course.name, '한강 여의도 코스');
      expect(course.distanceKm, 3.2);
      expect(course.difficulty, 3);
      expect(course.isOfficial, true);
    });

    test('should have nullable creatorId for official courses', () {
      final course = Course(
        id: '1',
        name: '공식 코스',
        routePoints: [],
        distanceKm: 5.0,
        estimatedMinutes: 30,
        difficulty: 2,
        isOfficial: true,
        averageRating: 0,
        totalRuns: 0,
        createdAt: DateTime.now(),
      );

      expect(course.creatorId, isNull);
    });
  });
}
