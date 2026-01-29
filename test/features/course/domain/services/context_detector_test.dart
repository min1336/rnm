import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/services/context_detector.dart';

void main() {
  late ContextDetector detector;

  setUp(() {
    detector = ContextDetector();
  });

  group('ContextDetector', () {
    test('weekday morning (6-8am) should return quick mode', () {
      // 월요일 오전 7시
      final monday7am = DateTime(2026, 1, 26, 7, 0); // 월요일
      final result = detector.detect(
        currentTime: monday7am,
        lastRunAt: DateTime(2026, 1, 25),
        recentCourseIds: [],
      );

      expect(result.context, RunningContext.quick);
      expect(result.isConfident, true);
    });

    test('weekend afternoon should return default mode with low confidence', () {
      // 토요일 오후 2시
      final saturday2pm = DateTime(2026, 1, 31, 14, 0); // 토요일
      final result = detector.detect(
        currentTime: saturday2pm,
        lastRunAt: DateTime(2026, 1, 30),
        recentCourseIds: [],
      );

      expect(result.context, RunningContext.defaultMode);
      expect(result.isConfident, false);
    });

    test('same course 3+ times should suggest explore mode', () {
      final result = detector.detect(
        currentTime: DateTime(2026, 1, 28, 18, 0),
        lastRunAt: DateTime(2026, 1, 27),
        recentCourseIds: ['course-1', 'course-1', 'course-1'],
      );

      expect(result.context, RunningContext.explore);
      expect(result.isConfident, true);
    });

    test('no run for 3+ days on weekend should suggest training', () {
      final saturday = DateTime(2026, 1, 31, 10, 0); // 토요일
      final result = detector.detect(
        currentTime: saturday,
        lastRunAt: DateTime(2026, 1, 26), // 5일 전
        recentCourseIds: [],
      );

      expect(result.context, RunningContext.training);
      expect(result.isConfident, true);
    });
  });
}
