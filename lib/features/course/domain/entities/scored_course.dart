import 'package:freezed_annotation/freezed_annotation.dart';
import 'course.dart';

part 'scored_course.freezed.dart';

@freezed
class ScoredCourse with _$ScoredCourse {
  const factory ScoredCourse({
    required Course course,
    required double totalScore,
    required String reason,
  }) = _ScoredCourse;
}
