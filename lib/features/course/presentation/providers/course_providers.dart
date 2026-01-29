import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/course_remote_datasource.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/running_context.dart';
import '../../domain/repositories/course_repository.dart';
import '../../domain/services/context_detector.dart';
import '../../domain/services/course_scorer.dart';
import '../../domain/services/recommendation_engine.dart';
import '../../domain/usecases/get_recommended_courses.dart';

// Supabase Client
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Data Sources
final courseRemoteDataSourceProvider = Provider<CourseRemoteDataSource>((ref) {
  return CourseRemoteDataSource(ref.watch(supabaseClientProvider));
});

// Repositories
final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepositoryImpl(ref.watch(courseRemoteDataSourceProvider));
});

// Services
final contextDetectorProvider = Provider<ContextDetector>((ref) {
  return ContextDetector();
});

final courseScorerProvider = Provider<CourseScorer>((ref) {
  return CourseScorer();
});

final recommendationEngineProvider = Provider<RecommendationEngine>((ref) {
  return RecommendationEngine(
    contextDetector: ref.watch(contextDetectorProvider),
    courseScorer: ref.watch(courseScorerProvider),
  );
});

// Use Cases
final getRecommendedCoursesProvider = Provider<GetRecommendedCourses>((ref) {
  return GetRecommendedCourses(
    repository: ref.watch(courseRepositoryProvider),
    engine: ref.watch(recommendationEngineProvider),
  );
});

// State
final selectedContextProvider = StateProvider<RunningContext?>((ref) => null);

final userLocationProvider = StateProvider<({double lat, double lng})?>(
  (ref) => null,
);

// Course Detail
final courseDetailProvider = FutureProvider.autoDispose.family<Course?, String>((ref, courseId) async {
  final repository = ref.watch(courseRepositoryProvider);
  return repository.getCourseById(courseId);
});

// Recommendations
final recommendationsProvider = FutureProvider.autoDispose<RecommendationResult>((ref) async {
  final useCase = ref.watch(getRecommendedCoursesProvider);
  final location = ref.watch(userLocationProvider);
  final overrideContext = ref.watch(selectedContextProvider);

  // 위치가 없으면 기본값 사용 (서울 시청)
  final lat = location?.lat ?? 37.5665;
  final lng = location?.lng ?? 126.9780;

  // TODO: 실제 사용자 ID 사용 (인증 시스템 연동 후)
  const userId = 'current-user';

  return useCase.execute(
    userId: userId,
    userLat: lat,
    userLng: lng,
    overrideContext: overrideContext,
  );
});
