import '../entities/course.dart';
import '../entities/user_running_profile.dart';

abstract class CourseRepository {
  /// 모든 코스 조회
  Future<List<Course>> getAllCourses();

  /// 코스 상세 조회
  Future<Course?> getCourseById(String id);

  /// 사용자 프로필 조회
  Future<UserRunningProfile?> getUserProfile(String userId);

  /// 최근 러닝한 코스 ID 목록 조회
  Future<List<String>> getRecentCourseIds(String userId, {int limit = 10});

  /// 코스 평가
  Future<void> rateCourse({
    required String courseId,
    required String userId,
    required int rating,
  });

  /// 코스 공유 (사용자 생성 코스)
  Future<Course> shareCourse(Course course);
}
