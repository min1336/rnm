import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';

@freezed
class LatLng with _$LatLng {
  const factory LatLng(double latitude, double longitude) = _LatLng;
}

@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String name,
    String? description,
    required List<LatLng> routePoints,
    required double distanceKm,
    required int estimatedMinutes,
    required int difficulty,
    String? creatorId,
    required bool isOfficial,
    required double averageRating,
    required int totalRuns,
    required DateTime createdAt,
  }) = _Course;
}
