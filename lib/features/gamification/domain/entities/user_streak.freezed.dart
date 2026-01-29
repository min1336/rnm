// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_streak.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserStreak {
  String get userId => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  DateTime? get lastRunDate => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of UserStreak
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStreakCopyWith<UserStreak> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStreakCopyWith<$Res> {
  factory $UserStreakCopyWith(
    UserStreak value,
    $Res Function(UserStreak) then,
  ) = _$UserStreakCopyWithImpl<$Res, UserStreak>;
  @useResult
  $Res call({
    String userId,
    int currentStreak,
    int longestStreak,
    DateTime? lastRunDate,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$UserStreakCopyWithImpl<$Res, $Val extends UserStreak>
    implements $UserStreakCopyWith<$Res> {
  _$UserStreakCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStreak
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastRunDate = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            lastRunDate: freezed == lastRunDate
                ? _value.lastRunDate
                : lastRunDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserStreakImplCopyWith<$Res>
    implements $UserStreakCopyWith<$Res> {
  factory _$$UserStreakImplCopyWith(
    _$UserStreakImpl value,
    $Res Function(_$UserStreakImpl) then,
  ) = __$$UserStreakImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    int currentStreak,
    int longestStreak,
    DateTime? lastRunDate,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserStreakImplCopyWithImpl<$Res>
    extends _$UserStreakCopyWithImpl<$Res, _$UserStreakImpl>
    implements _$$UserStreakImplCopyWith<$Res> {
  __$$UserStreakImplCopyWithImpl(
    _$UserStreakImpl _value,
    $Res Function(_$UserStreakImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserStreak
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastRunDate = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserStreakImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        lastRunDate: freezed == lastRunDate
            ? _value.lastRunDate
            : lastRunDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$UserStreakImpl implements _UserStreak {
  const _$UserStreakImpl({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    this.lastRunDate,
    required this.updatedAt,
  });

  @override
  final String userId;
  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final DateTime? lastRunDate;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserStreak(userId: $userId, currentStreak: $currentStreak, longestStreak: $longestStreak, lastRunDate: $lastRunDate, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStreakImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastRunDate, lastRunDate) ||
                other.lastRunDate == lastRunDate) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    currentStreak,
    longestStreak,
    lastRunDate,
    updatedAt,
  );

  /// Create a copy of UserStreak
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStreakImplCopyWith<_$UserStreakImpl> get copyWith =>
      __$$UserStreakImplCopyWithImpl<_$UserStreakImpl>(this, _$identity);
}

abstract class _UserStreak implements UserStreak {
  const factory _UserStreak({
    required final String userId,
    required final int currentStreak,
    required final int longestStreak,
    final DateTime? lastRunDate,
    required final DateTime updatedAt,
  }) = _$UserStreakImpl;

  @override
  String get userId;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  DateTime? get lastRunDate;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserStreak
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStreakImplCopyWith<_$UserStreakImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
