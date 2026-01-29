import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/entities/scored_course.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';
import 'package:running_mate/features/course/domain/repositories/course_repository.dart';
import 'package:running_mate/features/course/domain/services/context_detector.dart';
import 'package:running_mate/features/course/domain/services/recommendation_engine.dart';
import 'package:running_mate/features/course/domain/usecases/get_recommended_courses.dart';

@GenerateMocks([CourseRepository, RecommendationEngine])
import 'get_recommended_courses_test.mocks.dart';

void main() {
  late GetRecommendedCourses useCase;
  late MockCourseRepository mockRepository;
  late MockRecommendationEngine mockEngine;

  setUp(() {
    mockRepository = MockCourseRepository();
    mockEngine = MockRecommendationEngine();
    useCase = GetRecommendedCourses(
      repository: mockRepository,
      engine: mockEngine,
    );
  });

  group('GetRecommendedCourses', () {
    final courses = [
      Course(
        id: '1',
        name: 'Test',
        routePoints: [],
        distanceKm: 3.0,
        estimatedMinutes: 18,
        difficulty: 3,
        isOfficial: true,
        averageRating: 4.0,
        totalRuns: 100,
        createdAt: DateTime.now(),
      ),
    ];

    final profile = UserRunningProfile(
      userId: 'user-1',
      averagePaceMinPerKm: 6.0,
      averageDistanceKm: 5.0,
      weeklyRunCount: 3,
      calculatedLevel: 3,
      lastRunAt: DateTime.now(),
      levelUpdatedAt: DateTime.now(),
    );

    final scoredCourses = [
      ScoredCourse(
        course: courses.first,
        totalScore: 85.0,
        reason: '추천 코스',
      ),
    ];

    test('should fetch courses and return recommendations', () async {
      when(mockRepository.getAllCourses()).thenAnswer((_) async => courses);
      when(mockRepository.getUserProfile('user-1')).thenAnswer((_) async => profile);
      when(mockRepository.getRecentCourseIds('user-1')).thenAnswer((_) async => []);
      when(mockEngine.detectContext(
        currentTime: anyNamed('currentTime'),
        lastRunAt: anyNamed('lastRunAt'),
        recentCourseIds: anyNamed('recentCourseIds'),
      )).thenReturn(const ContextDetectionResult(
        context: RunningContext.defaultMode,
        isConfident: true,
      ));
      when(mockEngine.recommend(
        courses: anyNamed('courses'),
        profile: anyNamed('profile'),
        userLat: anyNamed('userLat'),
        userLng: anyNamed('userLng'),
        context: anyNamed('context'),
        limit: anyNamed('limit'),
      )).thenReturn(scoredCourses);

      final result = await useCase.execute(
        userId: 'user-1',
        userLat: 37.5,
        userLng: 127.0,
      );

      expect(result.courses.length, 1);
      expect(result.context, RunningContext.defaultMode);
      expect(result.needsConfirmation, false);
      verify(mockRepository.getAllCourses()).called(1);
    });

    test('should use default profile when user profile is null', () async {
      when(mockRepository.getAllCourses()).thenAnswer((_) async => courses);
      when(mockRepository.getUserProfile('new-user')).thenAnswer((_) async => null);
      when(mockRepository.getRecentCourseIds('new-user')).thenAnswer((_) async => []);
      when(mockEngine.detectContext(
        currentTime: anyNamed('currentTime'),
        lastRunAt: anyNamed('lastRunAt'),
        recentCourseIds: anyNamed('recentCourseIds'),
      )).thenReturn(const ContextDetectionResult(
        context: RunningContext.defaultMode,
        isConfident: false,
      ));
      when(mockEngine.recommend(
        courses: anyNamed('courses'),
        profile: anyNamed('profile'),
        userLat: anyNamed('userLat'),
        userLng: anyNamed('userLng'),
        context: anyNamed('context'),
        limit: anyNamed('limit'),
      )).thenReturn(scoredCourses);

      final result = await useCase.execute(
        userId: 'new-user',
        userLat: 37.5,
        userLng: 127.0,
      );

      expect(result.needsConfirmation, true);
    });
  });
}
