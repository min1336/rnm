import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/course.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
class RoutePointModel with _$RoutePointModel {
  const factory RoutePointModel({
    required double lat,
    required double lng,
  }) = _RoutePointModel;

  factory RoutePointModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePointModelFromJson(json);
}

@freezed
class CourseModel with _$CourseModel {
  const CourseModel._();

  const factory CourseModel({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'route_points') required List<RoutePointModel> routePoints,
    @JsonKey(name: 'distance_km') required double distanceKm,
    @JsonKey(name: 'estimated_minutes') required int estimatedMinutes,
    required int difficulty,
    @JsonKey(name: 'creator_id') String? creatorId,
    @JsonKey(name: 'is_official') required bool isOfficial,
    @JsonKey(name: 'average_rating') required double averageRating,
    @JsonKey(name: 'total_runs') required int totalRuns,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Course toEntity() {
    return Course(
      id: id,
      name: name,
      description: description,
      routePoints: routePoints
          .map((p) => LatLng(p.lat, p.lng))
          .toList(),
      distanceKm: distanceKm,
      estimatedMinutes: estimatedMinutes,
      difficulty: difficulty,
      creatorId: creatorId,
      isOfficial: isOfficial,
      averageRating: averageRating,
      totalRuns: totalRuns,
      createdAt: DateTime.parse(createdAt),
    );
  }

  static CourseModel fromEntity(Course entity) {
    return CourseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      routePoints: entity.routePoints
          .map((p) => RoutePointModel(lat: p.latitude, lng: p.longitude))
          .toList(),
      distanceKm: entity.distanceKm,
      estimatedMinutes: entity.estimatedMinutes,
      difficulty: entity.difficulty,
      creatorId: entity.creatorId,
      isOfficial: entity.isOfficial,
      averageRating: entity.averageRating,
      totalRuns: entity.totalRuns,
      createdAt: entity.createdAt.toIso8601String(),
    );
  }
}
