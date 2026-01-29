// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoutePointModel _$RoutePointModelFromJson(Map<String, dynamic> json) {
  return _RoutePointModel.fromJson(json);
}

/// @nodoc
mixin _$RoutePointModel {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  /// Serializes this RoutePointModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoutePointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutePointModelCopyWith<RoutePointModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutePointModelCopyWith<$Res> {
  factory $RoutePointModelCopyWith(
    RoutePointModel value,
    $Res Function(RoutePointModel) then,
  ) = _$RoutePointModelCopyWithImpl<$Res, RoutePointModel>;
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class _$RoutePointModelCopyWithImpl<$Res, $Val extends RoutePointModel>
    implements $RoutePointModelCopyWith<$Res> {
  _$RoutePointModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutePointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _value.copyWith(
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoutePointModelImplCopyWith<$Res>
    implements $RoutePointModelCopyWith<$Res> {
  factory _$$RoutePointModelImplCopyWith(
    _$RoutePointModelImpl value,
    $Res Function(_$RoutePointModelImpl) then,
  ) = __$$RoutePointModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class __$$RoutePointModelImplCopyWithImpl<$Res>
    extends _$RoutePointModelCopyWithImpl<$Res, _$RoutePointModelImpl>
    implements _$$RoutePointModelImplCopyWith<$Res> {
  __$$RoutePointModelImplCopyWithImpl(
    _$RoutePointModelImpl _value,
    $Res Function(_$RoutePointModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoutePointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _$RoutePointModelImpl(
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutePointModelImpl implements _RoutePointModel {
  const _$RoutePointModelImpl({required this.lat, required this.lng});

  factory _$RoutePointModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutePointModelImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'RoutePointModel(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutePointModelImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of RoutePointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutePointModelImplCopyWith<_$RoutePointModelImpl> get copyWith =>
      __$$RoutePointModelImplCopyWithImpl<_$RoutePointModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutePointModelImplToJson(this);
  }
}

abstract class _RoutePointModel implements RoutePointModel {
  const factory _RoutePointModel({
    required final double lat,
    required final double lng,
  }) = _$RoutePointModelImpl;

  factory _RoutePointModel.fromJson(Map<String, dynamic> json) =
      _$RoutePointModelImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;

  /// Create a copy of RoutePointModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutePointModelImplCopyWith<_$RoutePointModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return _CourseModel.fromJson(json);
}

/// @nodoc
mixin _$CourseModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_points')
  List<RoutePointModel> get routePoints => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_km')
  double get distanceKm => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_minutes')
  int get estimatedMinutes => throw _privateConstructorUsedError;
  int get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'creator_id')
  String? get creatorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_official')
  bool get isOfficial => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating')
  double get averageRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_runs')
  int get totalRuns => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CourseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseModelCopyWith<CourseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseModelCopyWith<$Res> {
  factory $CourseModelCopyWith(
    CourseModel value,
    $Res Function(CourseModel) then,
  ) = _$CourseModelCopyWithImpl<$Res, CourseModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    @JsonKey(name: 'route_points') List<RoutePointModel> routePoints,
    @JsonKey(name: 'distance_km') double distanceKm,
    @JsonKey(name: 'estimated_minutes') int estimatedMinutes,
    int difficulty,
    @JsonKey(name: 'creator_id') String? creatorId,
    @JsonKey(name: 'is_official') bool isOfficial,
    @JsonKey(name: 'average_rating') double averageRating,
    @JsonKey(name: 'total_runs') int totalRuns,
    @JsonKey(name: 'created_at') String createdAt,
  });
}

/// @nodoc
class _$CourseModelCopyWithImpl<$Res, $Val extends CourseModel>
    implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? routePoints = null,
    Object? distanceKm = null,
    Object? estimatedMinutes = null,
    Object? difficulty = null,
    Object? creatorId = freezed,
    Object? isOfficial = null,
    Object? averageRating = null,
    Object? totalRuns = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            routePoints: null == routePoints
                ? _value.routePoints
                : routePoints // ignore: cast_nullable_to_non_nullable
                      as List<RoutePointModel>,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedMinutes: null == estimatedMinutes
                ? _value.estimatedMinutes
                : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as int,
            creatorId: freezed == creatorId
                ? _value.creatorId
                : creatorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isOfficial: null == isOfficial
                ? _value.isOfficial
                : isOfficial // ignore: cast_nullable_to_non_nullable
                      as bool,
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
            totalRuns: null == totalRuns
                ? _value.totalRuns
                : totalRuns // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseModelImplCopyWith<$Res>
    implements $CourseModelCopyWith<$Res> {
  factory _$$CourseModelImplCopyWith(
    _$CourseModelImpl value,
    $Res Function(_$CourseModelImpl) then,
  ) = __$$CourseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    @JsonKey(name: 'route_points') List<RoutePointModel> routePoints,
    @JsonKey(name: 'distance_km') double distanceKm,
    @JsonKey(name: 'estimated_minutes') int estimatedMinutes,
    int difficulty,
    @JsonKey(name: 'creator_id') String? creatorId,
    @JsonKey(name: 'is_official') bool isOfficial,
    @JsonKey(name: 'average_rating') double averageRating,
    @JsonKey(name: 'total_runs') int totalRuns,
    @JsonKey(name: 'created_at') String createdAt,
  });
}

/// @nodoc
class __$$CourseModelImplCopyWithImpl<$Res>
    extends _$CourseModelCopyWithImpl<$Res, _$CourseModelImpl>
    implements _$$CourseModelImplCopyWith<$Res> {
  __$$CourseModelImplCopyWithImpl(
    _$CourseModelImpl _value,
    $Res Function(_$CourseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? routePoints = null,
    Object? distanceKm = null,
    Object? estimatedMinutes = null,
    Object? difficulty = null,
    Object? creatorId = freezed,
    Object? isOfficial = null,
    Object? averageRating = null,
    Object? totalRuns = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$CourseModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        routePoints: null == routePoints
            ? _value._routePoints
            : routePoints // ignore: cast_nullable_to_non_nullable
                  as List<RoutePointModel>,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedMinutes: null == estimatedMinutes
            ? _value.estimatedMinutes
            : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as int,
        creatorId: freezed == creatorId
            ? _value.creatorId
            : creatorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isOfficial: null == isOfficial
            ? _value.isOfficial
            : isOfficial // ignore: cast_nullable_to_non_nullable
                  as bool,
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
        totalRuns: null == totalRuns
            ? _value.totalRuns
            : totalRuns // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseModelImpl extends _CourseModel {
  const _$CourseModelImpl({
    required this.id,
    required this.name,
    this.description,
    @JsonKey(name: 'route_points')
    required final List<RoutePointModel> routePoints,
    @JsonKey(name: 'distance_km') required this.distanceKm,
    @JsonKey(name: 'estimated_minutes') required this.estimatedMinutes,
    required this.difficulty,
    @JsonKey(name: 'creator_id') this.creatorId,
    @JsonKey(name: 'is_official') required this.isOfficial,
    @JsonKey(name: 'average_rating') required this.averageRating,
    @JsonKey(name: 'total_runs') required this.totalRuns,
    @JsonKey(name: 'created_at') required this.createdAt,
  }) : _routePoints = routePoints,
       super._();

  factory _$CourseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  final List<RoutePointModel> _routePoints;
  @override
  @JsonKey(name: 'route_points')
  List<RoutePointModel> get routePoints {
    if (_routePoints is EqualUnmodifiableListView) return _routePoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routePoints);
  }

  @override
  @JsonKey(name: 'distance_km')
  final double distanceKm;
  @override
  @JsonKey(name: 'estimated_minutes')
  final int estimatedMinutes;
  @override
  final int difficulty;
  @override
  @JsonKey(name: 'creator_id')
  final String? creatorId;
  @override
  @JsonKey(name: 'is_official')
  final bool isOfficial;
  @override
  @JsonKey(name: 'average_rating')
  final double averageRating;
  @override
  @JsonKey(name: 'total_runs')
  final int totalRuns;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'CourseModel(id: $id, name: $name, description: $description, routePoints: $routePoints, distanceKm: $distanceKm, estimatedMinutes: $estimatedMinutes, difficulty: $difficulty, creatorId: $creatorId, isOfficial: $isOfficial, averageRating: $averageRating, totalRuns: $totalRuns, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._routePoints,
              _routePoints,
            ) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.isOfficial, isOfficial) ||
                other.isOfficial == isOfficial) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRuns, totalRuns) ||
                other.totalRuns == totalRuns) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    const DeepCollectionEquality().hash(_routePoints),
    distanceKm,
    estimatedMinutes,
    difficulty,
    creatorId,
    isOfficial,
    averageRating,
    totalRuns,
    createdAt,
  );

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      __$$CourseModelImplCopyWithImpl<_$CourseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseModelImplToJson(this);
  }
}

abstract class _CourseModel extends CourseModel {
  const factory _CourseModel({
    required final String id,
    required final String name,
    final String? description,
    @JsonKey(name: 'route_points')
    required final List<RoutePointModel> routePoints,
    @JsonKey(name: 'distance_km') required final double distanceKm,
    @JsonKey(name: 'estimated_minutes') required final int estimatedMinutes,
    required final int difficulty,
    @JsonKey(name: 'creator_id') final String? creatorId,
    @JsonKey(name: 'is_official') required final bool isOfficial,
    @JsonKey(name: 'average_rating') required final double averageRating,
    @JsonKey(name: 'total_runs') required final int totalRuns,
    @JsonKey(name: 'created_at') required final String createdAt,
  }) = _$CourseModelImpl;
  const _CourseModel._() : super._();

  factory _CourseModel.fromJson(Map<String, dynamic> json) =
      _$CourseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'route_points')
  List<RoutePointModel> get routePoints;
  @override
  @JsonKey(name: 'distance_km')
  double get distanceKm;
  @override
  @JsonKey(name: 'estimated_minutes')
  int get estimatedMinutes;
  @override
  int get difficulty;
  @override
  @JsonKey(name: 'creator_id')
  String? get creatorId;
  @override
  @JsonKey(name: 'is_official')
  bool get isOfficial;
  @override
  @JsonKey(name: 'average_rating')
  double get averageRating;
  @override
  @JsonKey(name: 'total_runs')
  int get totalRuns;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
