import '../entities/course.dart';
import '../entities/running_context.dart';
import '../entities/scored_course.dart';
import '../entities/user_running_profile.dart';
import 'context_detector.dart';
import 'course_scorer.dart';

class RecommendationEngine {
  final ContextDetector contextDetector;
  final CourseScorer courseScorer;

  const RecommendationEngine({
    required this.contextDetector,
    required this.courseScorer,
  });

  List<ScoredCourse> recommend({
    required List<Course> courses,
    required UserRunningProfile profile,
    required double userLat,
    required double userLng,
    required RunningContext context,
    int limit = 10,
  }) {
    final scoredCourses = courses.map((course) {
      return courseScorer.score(
        course: course,
        profile: profile,
        userLat: userLat,
        userLng: userLng,
        weights: context.weights,
      );
    }).toList();

    // 점수 높은 순으로 정렬
    scoredCourses.sort((a, b) => b.totalScore.compareTo(a.totalScore));

    // 상위 N개 반환
    return scoredCourses.take(limit).toList();
  }

  ContextDetectionResult detectContext({
    required DateTime currentTime,
    required DateTime? lastRunAt,
    required List<String> recentCourseIds,
  }) {
    return contextDetector.detect(
      currentTime: currentTime,
      lastRunAt: lastRunAt,
      recentCourseIds: recentCourseIds,
    );
  }
}
