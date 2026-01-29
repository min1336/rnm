import '../../domain/entities/course.dart';
import '../../domain/entities/user_running_profile.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_remote_datasource.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource _dataSource;

  CourseRepositoryImpl(this._dataSource);

  @override
  Future<List<Course>> getAllCourses() async {
    final models = await _dataSource.getAllCourses();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Course?> getCourseById(String id) async {
    final model = await _dataSource.getCourseById(id);
    return model?.toEntity();
  }

  @override
  Future<UserRunningProfile?> getUserProfile(String userId) async {
    final data = await _dataSource.getUserProfile(userId);
    if (data == null) return null;

    return UserRunningProfile(
      userId: data['user_id'],
      averagePaceMinPerKm: (data['average_pace_min_per_km'] as num).toDouble(),
      averageDistanceKm: (data['average_distance_km'] as num).toDouble(),
      weeklyRunCount: data['weekly_run_count'],
      calculatedLevel: data['calculated_level'],
      goal: _parseGoal(data['goal']),
      lastRunAt: DateTime.parse(data['last_run_at']),
      levelUpdatedAt: DateTime.parse(data['level_updated_at']),
    );
  }

  RunningGoal? _parseGoal(String? goal) {
    if (goal == null) return null;
    return RunningGoal.values.firstWhere(
      (g) => g.name == goal,
      orElse: () => RunningGoal.health,
    );
  }

  @override
  Future<List<String>> getRecentCourseIds(String userId, {int limit = 10}) {
    return _dataSource.getRecentCourseIds(userId, limit: limit);
  }

  @override
  Future<void> rateCourse({
    required String courseId,
    required String userId,
    required int rating,
  }) {
    return _dataSource.rateCourse(
      courseId: courseId,
      userId: userId,
      rating: rating,
    );
  }

  @override
  Future<Course> shareCourse(Course course) async {
    final model = CourseModel.fromEntity(course);
    final created = await _dataSource.createCourse(model);
    return created.toEntity();
  }
}
