import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/course/data/datasources/course_remote_datasource.dart';
import 'package:running_mate/features/course/data/models/course_model.dart';
import 'package:running_mate/features/course/data/repositories/course_repository_impl.dart';

@GenerateMocks([CourseRemoteDataSource])
import 'course_repository_impl_test.mocks.dart';

void main() {
  late CourseRepositoryImpl repository;
  late MockCourseRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCourseRemoteDataSource();
    repository = CourseRepositoryImpl(mockDataSource);
  });

  group('CourseRepositoryImpl', () {
    test('getAllCourses should return list of Course entities', () async {
      final models = [
        CourseModel(
          id: '1',
          name: 'Test Course',
          routePoints: [],
          distanceKm: 3.0,
          estimatedMinutes: 18,
          difficulty: 3,
          isOfficial: true,
          averageRating: 4.0,
          totalRuns: 100,
          createdAt: '2026-01-15T10:00:00.000Z',
        ),
      ];

      when(mockDataSource.getAllCourses()).thenAnswer((_) async => models);

      final result = await repository.getAllCourses();

      expect(result.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Test Course');
      verify(mockDataSource.getAllCourses()).called(1);
    });
  });
}
