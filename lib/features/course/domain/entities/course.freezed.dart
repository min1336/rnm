// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LatLng {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatLngCopyWith<LatLng> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngCopyWith<$Res> {
  factory $LatLngCopyWith(LatLng value, $Res Function(LatLng) then) =
      _$LatLngCopyWithImpl<$Res, LatLng>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$LatLngCopyWithImpl<$Res, $Val extends LatLng>
    implements $LatLngCopyWith<$Res> {
  _$LatLngCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LatLngImplCopyWith<$Res> implements $LatLngCopyWith<$Res> {
  factory _$$LatLngImplCopyWith(
    _$LatLngImpl value,
    $Res Function(_$LatLngImpl) then,
  ) = __$$LatLngImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$LatLngImplCopyWithImpl<$Res>
    extends _$LatLngCopyWithImpl<$Res, _$LatLngImpl>
    implements _$$LatLngImplCopyWith<$Res> {
  __$$LatLngImplCopyWithImpl(
    _$LatLngImpl _value,
    $Res Function(_$LatLngImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _$LatLngImpl(
        null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$LatLngImpl implements _LatLng {
  const _$LatLngImpl(this.latitude, this.longitude);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'LatLng(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      __$$LatLngImplCopyWithImpl<_$LatLngImpl>(this, _$identity);
}

abstract class _LatLng implements LatLng {
  const factory _LatLng(final double latitude, final double longitude) =
      _$LatLngImpl;

  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Course {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<LatLng> get routePoints => throw _privateConstructorUsedError;
  double get distanceKm => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;
  int get difficulty => throw _privateConstructorUsedError;
  String? get creatorId => throw _privateConstructorUsedError;
  bool get isOfficial => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalRuns => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    List<LatLng> routePoints,
    double distanceKm,
    int estimatedMinutes,
    int difficulty,
    String? creatorId,
    bool isOfficial,
    double averageRating,
    int totalRuns,
    DateTime createdAt,
  });
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Course
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
                      as List<LatLng>,
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
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
    _$CourseImpl value,
    $Res Function(_$CourseImpl) then,
  ) = __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    List<LatLng> routePoints,
    double distanceKm,
    int estimatedMinutes,
    int difficulty,
    String? creatorId,
    bool isOfficial,
    double averageRating,
    int totalRuns,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
    _$CourseImpl _value,
    $Res Function(_$CourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Course
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
      _$CourseImpl(
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
                  as List<LatLng>,
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
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$CourseImpl implements _Course {
  const _$CourseImpl({
    required this.id,
    required this.name,
    this.description,
    required final List<LatLng> routePoints,
    required this.distanceKm,
    required this.estimatedMinutes,
    required this.difficulty,
    this.creatorId,
    required this.isOfficial,
    required this.averageRating,
    required this.totalRuns,
    required this.createdAt,
  }) : _routePoints = routePoints;

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  final List<LatLng> _routePoints;
  @override
  List<LatLng> get routePoints {
    if (_routePoints is EqualUnmodifiableListView) return _routePoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routePoints);
  }

  @override
  final double distanceKm;
  @override
  final int estimatedMinutes;
  @override
  final int difficulty;
  @override
  final String? creatorId;
  @override
  final bool isOfficial;
  @override
  final double averageRating;
  @override
  final int totalRuns;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Course(id: $id, name: $name, description: $description, routePoints: $routePoints, distanceKm: $distanceKm, estimatedMinutes: $estimatedMinutes, difficulty: $difficulty, creatorId: $creatorId, isOfficial: $isOfficial, averageRating: $averageRating, totalRuns: $totalRuns, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
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

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);
}

abstract class _Course implements Course {
  const factory _Course({
    required final String id,
    required final String name,
    final String? description,
    required final List<LatLng> routePoints,
    required final double distanceKm,
    required final int estimatedMinutes,
    required final int difficulty,
    final String? creatorId,
    required final bool isOfficial,
    required final double averageRating,
    required final int totalRuns,
    required final DateTime createdAt,
  }) = _$CourseImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  List<LatLng> get routePoints;
  @override
  double get distanceKm;
  @override
  int get estimatedMinutes;
  @override
  int get difficulty;
  @override
  String? get creatorId;
  @override
  bool get isOfficial;
  @override
  double get averageRating;
  @override
  int get totalRuns;
  @override
  DateTime get createdAt;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
