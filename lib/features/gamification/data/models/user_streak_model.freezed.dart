// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_streak_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserStreakModel _$UserStreakModelFromJson(Map<String, dynamic> json) {
  return _UserStreakModel.fromJson(json);
}

/// @nodoc
mixin _$UserStreakModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_streak')
  int get currentStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'longest_streak')
  int get longestStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_run_date')
  String? get lastRunDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserStreakModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStreakModelCopyWith<UserStreakModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStreakModelCopyWith<$Res> {
  factory $UserStreakModelCopyWith(
    UserStreakModel value,
    $Res Function(UserStreakModel) then,
  ) = _$UserStreakModelCopyWithImpl<$Res, UserStreakModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'current_streak') int currentStreak,
    @JsonKey(name: 'longest_streak') int longestStreak,
    @JsonKey(name: 'last_run_date') String? lastRunDate,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class _$UserStreakModelCopyWithImpl<$Res, $Val extends UserStreakModel>
    implements $UserStreakModelCopyWith<$Res> {
  _$UserStreakModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStreakModel
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
                      as String?,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserStreakModelImplCopyWith<$Res>
    implements $UserStreakModelCopyWith<$Res> {
  factory _$$UserStreakModelImplCopyWith(
    _$UserStreakModelImpl value,
    $Res Function(_$UserStreakModelImpl) then,
  ) = __$$UserStreakModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'current_streak') int currentStreak,
    @JsonKey(name: 'longest_streak') int longestStreak,
    @JsonKey(name: 'last_run_date') String? lastRunDate,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class __$$UserStreakModelImplCopyWithImpl<$Res>
    extends _$UserStreakModelCopyWithImpl<$Res, _$UserStreakModelImpl>
    implements _$$UserStreakModelImplCopyWith<$Res> {
  __$$UserStreakModelImplCopyWithImpl(
    _$UserStreakModelImpl _value,
    $Res Function(_$UserStreakModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserStreakModel
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
      _$UserStreakModelImpl(
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
                  as String?,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStreakModelImpl extends _UserStreakModel {
  const _$UserStreakModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'current_streak') required this.currentStreak,
    @JsonKey(name: 'longest_streak') required this.longestStreak,
    @JsonKey(name: 'last_run_date') this.lastRunDate,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : super._();

  factory _$UserStreakModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStreakModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'current_streak')
  final int currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  final int longestStreak;
  @override
  @JsonKey(name: 'last_run_date')
  final String? lastRunDate;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @override
  String toString() {
    return 'UserStreakModel(userId: $userId, currentStreak: $currentStreak, longestStreak: $longestStreak, lastRunDate: $lastRunDate, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStreakModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    currentStreak,
    longestStreak,
    lastRunDate,
    updatedAt,
  );

  /// Create a copy of UserStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStreakModelImplCopyWith<_$UserStreakModelImpl> get copyWith =>
      __$$UserStreakModelImplCopyWithImpl<_$UserStreakModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStreakModelImplToJson(this);
  }
}

abstract class _UserStreakModel extends UserStreakModel {
  const factory _UserStreakModel({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'current_streak') required final int currentStreak,
    @JsonKey(name: 'longest_streak') required final int longestStreak,
    @JsonKey(name: 'last_run_date') final String? lastRunDate,
    @JsonKey(name: 'updated_at') required final String updatedAt,
  }) = _$UserStreakModelImpl;
  const _UserStreakModel._() : super._();

  factory _UserStreakModel.fromJson(Map<String, dynamic> json) =
      _$UserStreakModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'current_streak')
  int get currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  int get longestStreak;
  @override
  @JsonKey(name: 'last_run_date')
  String? get lastRunDate;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of UserStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStreakModelImplCopyWith<_$UserStreakModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
