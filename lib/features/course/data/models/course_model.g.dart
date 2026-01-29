// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutePointModelImpl _$$RoutePointModelImplFromJson(
  Map<String, dynamic> json,
) => _$RoutePointModelImpl(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$$RoutePointModelImplToJson(
  _$RoutePointModelImpl instance,
) => <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

_$CourseModelImpl _$$CourseModelImplFromJson(Map<String, dynamic> json) =>
    _$CourseModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      routePoints: (json['route_points'] as List<dynamic>)
          .map((e) => RoutePointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      distanceKm: (json['distance_km'] as num).toDouble(),
      estimatedMinutes: (json['estimated_minutes'] as num).toInt(),
      difficulty: (json['difficulty'] as num).toInt(),
      creatorId: json['creator_id'] as String?,
      isOfficial: json['is_official'] as bool,
      averageRating: (json['average_rating'] as num).toDouble(),
      totalRuns: (json['total_runs'] as num).toInt(),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$CourseModelImplToJson(_$CourseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'route_points': instance.routePoints,
      'distance_km': instance.distanceKm,
      'estimated_minutes': instance.estimatedMinutes,
      'difficulty': instance.difficulty,
      'creator_id': instance.creatorId,
      'is_official': instance.isOfficial,
      'average_rating': instance.averageRating,
      'total_runs': instance.totalRuns,
      'created_at': instance.createdAt,
    };
