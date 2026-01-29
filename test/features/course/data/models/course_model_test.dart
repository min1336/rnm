import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/data/models/course_model.dart';

void main() {
  group('CourseModel', () {
    final testJson = {
      'id': '123',
      'name': '한강 코스',
      'description': '좋은 코스입니다',
      'route_points': [
        {'lat': 37.5, 'lng': 127.0},
        {'lat': 37.51, 'lng': 127.01},
      ],
      'distance_km': 3.5,
      'estimated_minutes': 21,
      'difficulty': 3,
      'creator_id': 'user-1',
      'is_official': false,
      'average_rating': 4.2,
      'total_runs': 50,
      'created_at': '2026-01-15T10:00:00.000Z',
    };

    test('should parse from JSON correctly', () {
      final model = CourseModel.fromJson(testJson);

      expect(model.id, '123');
      expect(model.name, '한강 코스');
      expect(model.routePoints.length, 2);
      expect(model.distanceKm, 3.5);
      expect(model.difficulty, 3);
    });

    test('should convert to entity correctly', () {
      final model = CourseModel.fromJson(testJson);
      final entity = model.toEntity();

      expect(entity.id, '123');
      expect(entity.routePoints.first.latitude, 37.5);
    });

    test('should convert to JSON correctly', () {
      final model = CourseModel.fromJson(testJson);
      final json = model.toJson();

      expect(json['id'], '123');
      expect(json['distance_km'], 3.5);
    });
  });
}
