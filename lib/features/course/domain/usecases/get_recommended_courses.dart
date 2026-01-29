import '../entities/running_context.dart';
import '../entities/scored_course.dart';
import '../entities/user_running_profile.dart';
import '../repositories/course_repository.dart';
import '../services/recommendation_engine.dart';

class RecommendationResult {
  final List<ScoredCourse> courses;
  final RunningContext context;
  final bool needsConfirmation;

  const RecommendationResult({
    required this.courses,
    required this.context,
    required this.needsConfirmation,
  });
}

class GetRecommendedCourses {
  final CourseRepository repository;
  final RecommendationEngine engine;

  const GetRecommendedCourses({
    required this.repository,
    required this.engine,
  });

  Future<RecommendationResult> execute({
    required String userId,
    required double userLat,
    required double userLng,
    RunningContext? overrideContext,
    int limit = 10,
  }) async {
    // 1. 데이터 조회
    final courses = await repository.getAllCourses();
    final profile = await repository.getUserProfile(userId);
    final recentCourseIds = await repository.getRecentCourseIds(userId);

    // 프로필이 없으면 기본값 사용
    final effectiveProfile = profile ?? _defaultProfile(userId);

    // 2. 상황 감지 (override가 없을 때만)
    final RunningContext context;
    final bool needsConfirmation;

    if (overrideContext != null) {
      context = overrideContext;
      needsConfirmation = false;
    } else {
      final detection = engine.detectContext(
        currentTime: DateTime.now(),
        lastRunAt: effectiveProfile.lastRunAt,
        recentCourseIds: recentCourseIds,
      );
      context = detection.context;
      needsConfirmation = !detection.isConfident;
    }

    // 3. 추천 생성
    final recommendations = engine.recommend(
      courses: courses,
      profile: effectiveProfile,
      userLat: userLat,
      userLng: userLng,
      context: context,
      limit: limit,
    );

    return RecommendationResult(
      courses: recommendations,
      context: context,
      needsConfirmation: needsConfirmation,
    );
  }

  UserRunningProfile _defaultProfile(String userId) {
    return UserRunningProfile(
      userId: userId,
      averagePaceMinPerKm: 6.0,
      averageDistanceKm: 3.0,
      weeklyRunCount: 0,
      calculatedLevel: 3, // 중급으로 시작
      lastRunAt: DateTime.now(),
      levelUpdatedAt: DateTime.now(),
    );
  }
}
