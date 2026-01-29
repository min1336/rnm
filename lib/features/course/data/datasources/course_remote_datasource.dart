import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course_model.dart';

class CourseRemoteDataSource {
  final SupabaseClient _client;

  CourseRemoteDataSource(this._client);

  Future<List<CourseModel>> getAllCourses() async {
    final response = await _client
        .from('courses')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => CourseModel.fromJson(json))
        .toList();
  }

  Future<CourseModel?> getCourseById(String id) async {
    final response = await _client
        .from('courses')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return CourseModel.fromJson(response);
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _client
        .from('user_running_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    return response;
  }

  Future<List<String>> getRecentCourseIds(String userId, {int limit = 10}) async {
    final response = await _client
        .from('run_histories')
        .select('course_id')
        .eq('user_id', userId)
        .not('course_id', 'is', null)
        .order('run_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((row) => row['course_id'] as String)
        .toList();
  }

  Future<void> rateCourse({
    required String courseId,
    required String userId,
    required int rating,
  }) async {
    await _client.from('course_ratings').upsert({
      'course_id': courseId,
      'user_id': userId,
      'rating': rating,
    }, onConflict: 'course_id,user_id');

    // 평균 평점 업데이트
    await _updateAverageRating(courseId);
  }

  Future<void> _updateAverageRating(String courseId) async {
    final response = await _client
        .from('course_ratings')
        .select('rating')
        .eq('course_id', courseId);

    final ratings = (response as List).map((r) => r['rating'] as int);
    if (ratings.isEmpty) return;

    final average = ratings.reduce((a, b) => a + b) / ratings.length;

    await _client
        .from('courses')
        .update({'average_rating': average})
        .eq('id', courseId);
  }

  Future<CourseModel> createCourse(CourseModel course) async {
    final response = await _client
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return CourseModel.fromJson(response);
  }
}
