// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserStats {
  /// 총 러닝 횟수
  int get totalRuns => throw _privateConstructorUsedError;

  /// 총 누적 거리 (km)
  double get totalDistanceKm => throw _privateConstructorUsedError;

  /// 현재 연속 러닝 일수
  int get currentStreak => throw _privateConstructorUsedError;

  /// 고유 코스 탐험 개수
  int get uniqueCourseCount => throw _privateConstructorUsedError;

  /// 코스 공유 횟수
  int get sharedCourseCount => throw _privateConstructorUsedError;

  /// 새벽 러닝 횟수 (05:00-07:00)
  int get earlyRunCount => throw _privateConstructorUsedError;

  /// 야간 러닝 횟수 (21:00-23:00)
  int get nightRunCount => throw _privateConstructorUsedError;

  /// 주말 연속 러닝 횟수
  int get weekendStreak => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call({
    int totalRuns,
    double totalDistanceKm,
    int currentStreak,
    int uniqueCourseCount,
    int sharedCourseCount,
    int earlyRunCount,
    int nightRunCount,
    int weekendStreak,
  });
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRuns = null,
    Object? totalDistanceKm = null,
    Object? currentStreak = null,
    Object? uniqueCourseCount = null,
    Object? sharedCourseCount = null,
    Object? earlyRunCount = null,
    Object? nightRunCount = null,
    Object? weekendStreak = null,
  }) {
    return _then(
      _value.copyWith(
            totalRuns: null == totalRuns
                ? _value.totalRuns
                : totalRuns // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDistanceKm: null == totalDistanceKm
                ? _value.totalDistanceKm
                : totalDistanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            uniqueCourseCount: null == uniqueCourseCount
                ? _value.uniqueCourseCount
                : uniqueCourseCount // ignore: cast_nullable_to_non_nullable
                      as int,
            sharedCourseCount: null == sharedCourseCount
                ? _value.sharedCourseCount
                : sharedCourseCount // ignore: cast_nullable_to_non_nullable
                      as int,
            earlyRunCount: null == earlyRunCount
                ? _value.earlyRunCount
                : earlyRunCount // ignore: cast_nullable_to_non_nullable
                      as int,
            nightRunCount: null == nightRunCount
                ? _value.nightRunCount
                : nightRunCount // ignore: cast_nullable_to_non_nullable
                      as int,
            weekendStreak: null == weekendStreak
                ? _value.weekendStreak
                : weekendStreak // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
    _$UserStatsImpl value,
    $Res Function(_$UserStatsImpl) then,
  ) = __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalRuns,
    double totalDistanceKm,
    int currentStreak,
    int uniqueCourseCount,
    int sharedCourseCount,
    int earlyRunCount,
    int nightRunCount,
    int weekendStreak,
  });
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
    _$UserStatsImpl _value,
    $Res Function(_$UserStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRuns = null,
    Object? totalDistanceKm = null,
    Object? currentStreak = null,
    Object? uniqueCourseCount = null,
    Object? sharedCourseCount = null,
    Object? earlyRunCount = null,
    Object? nightRunCount = null,
    Object? weekendStreak = null,
  }) {
    return _then(
      _$UserStatsImpl(
        totalRuns: null == totalRuns
            ? _value.totalRuns
            : totalRuns // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDistanceKm: null == totalDistanceKm
            ? _value.totalDistanceKm
            : totalDistanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueCourseCount: null == uniqueCourseCount
            ? _value.uniqueCourseCount
            : uniqueCourseCount // ignore: cast_nullable_to_non_nullable
                  as int,
        sharedCourseCount: null == sharedCourseCount
            ? _value.sharedCourseCount
            : sharedCourseCount // ignore: cast_nullable_to_non_nullable
                  as int,
        earlyRunCount: null == earlyRunCount
            ? _value.earlyRunCount
            : earlyRunCount // ignore: cast_nullable_to_non_nullable
                  as int,
        nightRunCount: null == nightRunCount
            ? _value.nightRunCount
            : nightRunCount // ignore: cast_nullable_to_non_nullable
                  as int,
        weekendStreak: null == weekendStreak
            ? _value.weekendStreak
            : weekendStreak // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$UserStatsImpl implements _UserStats {
  const _$UserStatsImpl({
    required this.totalRuns,
    required this.totalDistanceKm,
    required this.currentStreak,
    required this.uniqueCourseCount,
    required this.sharedCourseCount,
    required this.earlyRunCount,
    required this.nightRunCount,
    required this.weekendStreak,
  });

  /// 총 러닝 횟수
  @override
  final int totalRuns;

  /// 총 누적 거리 (km)
  @override
  final double totalDistanceKm;

  /// 현재 연속 러닝 일수
  @override
  final int currentStreak;

  /// 고유 코스 탐험 개수
  @override
  final int uniqueCourseCount;

  /// 코스 공유 횟수
  @override
  final int sharedCourseCount;

  /// 새벽 러닝 횟수 (05:00-07:00)
  @override
  final int earlyRunCount;

  /// 야간 러닝 횟수 (21:00-23:00)
  @override
  final int nightRunCount;

  /// 주말 연속 러닝 횟수
  @override
  final int weekendStreak;

  @override
  String toString() {
    return 'UserStats(totalRuns: $totalRuns, totalDistanceKm: $totalDistanceKm, currentStreak: $currentStreak, uniqueCourseCount: $uniqueCourseCount, sharedCourseCount: $sharedCourseCount, earlyRunCount: $earlyRunCount, nightRunCount: $nightRunCount, weekendStreak: $weekendStreak)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.totalRuns, totalRuns) ||
                other.totalRuns == totalRuns) &&
            (identical(other.totalDistanceKm, totalDistanceKm) ||
                other.totalDistanceKm == totalDistanceKm) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.uniqueCourseCount, uniqueCourseCount) ||
                other.uniqueCourseCount == uniqueCourseCount) &&
            (identical(other.sharedCourseCount, sharedCourseCount) ||
                other.sharedCourseCount == sharedCourseCount) &&
            (identical(other.earlyRunCount, earlyRunCount) ||
                other.earlyRunCount == earlyRunCount) &&
            (identical(other.nightRunCount, nightRunCount) ||
                other.nightRunCount == nightRunCount) &&
            (identical(other.weekendStreak, weekendStreak) ||
                other.weekendStreak == weekendStreak));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalRuns,
    totalDistanceKm,
    currentStreak,
    uniqueCourseCount,
    sharedCourseCount,
    earlyRunCount,
    nightRunCount,
    weekendStreak,
  );

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);
}

abstract class _UserStats implements UserStats {
  const factory _UserStats({
    required final int totalRuns,
    required final double totalDistanceKm,
    required final int currentStreak,
    required final int uniqueCourseCount,
    required final int sharedCourseCount,
    required final int earlyRunCount,
    required final int nightRunCount,
    required final int weekendStreak,
  }) = _$UserStatsImpl;

  /// 총 러닝 횟수
  @override
  int get totalRuns;

  /// 총 누적 거리 (km)
  @override
  double get totalDistanceKm;

  /// 현재 연속 러닝 일수
  @override
  int get currentStreak;

  /// 고유 코스 탐험 개수
  @override
  int get uniqueCourseCount;

  /// 코스 공유 횟수
  @override
  int get sharedCourseCount;

  /// 새벽 러닝 횟수 (05:00-07:00)
  @override
  int get earlyRunCount;

  /// 야간 러닝 횟수 (21:00-23:00)
  @override
  int get nightRunCount;

  /// 주말 연속 러닝 횟수
  @override
  int get weekendStreak;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
