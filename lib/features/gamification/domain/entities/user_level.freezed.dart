// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserLevel {
  String get userId => throw _privateConstructorUsedError;
  int get currentXp => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of UserLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserLevelCopyWith<UserLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLevelCopyWith<$Res> {
  factory $UserLevelCopyWith(UserLevel value, $Res Function(UserLevel) then) =
      _$UserLevelCopyWithImpl<$Res, UserLevel>;
  @useResult
  $Res call({String userId, int currentXp, int level, DateTime updatedAt});
}

/// @nodoc
class _$UserLevelCopyWithImpl<$Res, $Val extends UserLevel>
    implements $UserLevelCopyWith<$Res> {
  _$UserLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentXp = null,
    Object? level = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentXp: null == currentXp
                ? _value.currentXp
                : currentXp // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$UserLevelImplCopyWith<$Res>
    implements $UserLevelCopyWith<$Res> {
  factory _$$UserLevelImplCopyWith(
    _$UserLevelImpl value,
    $Res Function(_$UserLevelImpl) then,
  ) = __$$UserLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, int currentXp, int level, DateTime updatedAt});
}

/// @nodoc
class __$$UserLevelImplCopyWithImpl<$Res>
    extends _$UserLevelCopyWithImpl<$Res, _$UserLevelImpl>
    implements _$$UserLevelImplCopyWith<$Res> {
  __$$UserLevelImplCopyWithImpl(
    _$UserLevelImpl _value,
    $Res Function(_$UserLevelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentXp = null,
    Object? level = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserLevelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentXp: null == currentXp
            ? _value.currentXp
            : currentXp // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$UserLevelImpl extends _UserLevel {
  const _$UserLevelImpl({
    required this.userId,
    required this.currentXp,
    required this.level,
    required this.updatedAt,
  }) : super._();

  @override
  final String userId;
  @override
  final int currentXp;
  @override
  final int level;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserLevel(userId: $userId, currentXp: $currentXp, level: $level, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLevelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentXp, currentXp) ||
                other.currentXp == currentXp) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, currentXp, level, updatedAt);

  /// Create a copy of UserLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLevelImplCopyWith<_$UserLevelImpl> get copyWith =>
      __$$UserLevelImplCopyWithImpl<_$UserLevelImpl>(this, _$identity);
}

abstract class _UserLevel extends UserLevel {
  const factory _UserLevel({
    required final String userId,
    required final int currentXp,
    required final int level,
    required final DateTime updatedAt,
  }) = _$UserLevelImpl;
  const _UserLevel._() : super._();

  @override
  String get userId;
  @override
  int get currentXp;
  @override
  int get level;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserLevel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLevelImplCopyWith<_$UserLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
