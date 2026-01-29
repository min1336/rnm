// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scored_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScoredCourse {
  Course get course => throw _privateConstructorUsedError;
  double get totalScore => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  /// Create a copy of ScoredCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoredCourseCopyWith<ScoredCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoredCourseCopyWith<$Res> {
  factory $ScoredCourseCopyWith(
    ScoredCourse value,
    $Res Function(ScoredCourse) then,
  ) = _$ScoredCourseCopyWithImpl<$Res, ScoredCourse>;
  @useResult
  $Res call({Course course, double totalScore, String reason});

  $CourseCopyWith<$Res> get course;
}

/// @nodoc
class _$ScoredCourseCopyWithImpl<$Res, $Val extends ScoredCourse>
    implements $ScoredCourseCopyWith<$Res> {
  _$ScoredCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScoredCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? course = null,
    Object? totalScore = null,
    Object? reason = null,
  }) {
    return _then(
      _value.copyWith(
            course: null == course
                ? _value.course
                : course // ignore: cast_nullable_to_non_nullable
                      as Course,
            totalScore: null == totalScore
                ? _value.totalScore
                : totalScore // ignore: cast_nullable_to_non_nullable
                      as double,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of ScoredCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseCopyWith<$Res> get course {
    return $CourseCopyWith<$Res>(_value.course, (value) {
      return _then(_value.copyWith(course: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScoredCourseImplCopyWith<$Res>
    implements $ScoredCourseCopyWith<$Res> {
  factory _$$ScoredCourseImplCopyWith(
    _$ScoredCourseImpl value,
    $Res Function(_$ScoredCourseImpl) then,
  ) = __$$ScoredCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Course course, double totalScore, String reason});

  @override
  $CourseCopyWith<$Res> get course;
}

/// @nodoc
class __$$ScoredCourseImplCopyWithImpl<$Res>
    extends _$ScoredCourseCopyWithImpl<$Res, _$ScoredCourseImpl>
    implements _$$ScoredCourseImplCopyWith<$Res> {
  __$$ScoredCourseImplCopyWithImpl(
    _$ScoredCourseImpl _value,
    $Res Function(_$ScoredCourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScoredCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? course = null,
    Object? totalScore = null,
    Object? reason = null,
  }) {
    return _then(
      _$ScoredCourseImpl(
        course: null == course
            ? _value.course
            : course // ignore: cast_nullable_to_non_nullable
                  as Course,
        totalScore: null == totalScore
            ? _value.totalScore
            : totalScore // ignore: cast_nullable_to_non_nullable
                  as double,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ScoredCourseImpl implements _ScoredCourse {
  const _$ScoredCourseImpl({
    required this.course,
    required this.totalScore,
    required this.reason,
  });

  @override
  final Course course;
  @override
  final double totalScore;
  @override
  final String reason;

  @override
  String toString() {
    return 'ScoredCourse(course: $course, totalScore: $totalScore, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoredCourseImpl &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, course, totalScore, reason);

  /// Create a copy of ScoredCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoredCourseImplCopyWith<_$ScoredCourseImpl> get copyWith =>
      __$$ScoredCourseImplCopyWithImpl<_$ScoredCourseImpl>(this, _$identity);
}

abstract class _ScoredCourse implements ScoredCourse {
  const factory _ScoredCourse({
    required final Course course,
    required final double totalScore,
    required final String reason,
  }) = _$ScoredCourseImpl;

  @override
  Course get course;
  @override
  double get totalScore;
  @override
  String get reason;

  /// Create a copy of ScoredCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoredCourseImplCopyWith<_$ScoredCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
