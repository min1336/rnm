// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserLevelModel _$UserLevelModelFromJson(Map<String, dynamic> json) {
  return _UserLevelModel.fromJson(json);
}

/// @nodoc
mixin _$UserLevelModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_xp')
  int get currentXp => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserLevelModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserLevelModelCopyWith<UserLevelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLevelModelCopyWith<$Res> {
  factory $UserLevelModelCopyWith(
    UserLevelModel value,
    $Res Function(UserLevelModel) then,
  ) = _$UserLevelModelCopyWithImpl<$Res, UserLevelModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'current_xp') int currentXp,
    int level,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class _$UserLevelModelCopyWithImpl<$Res, $Val extends UserLevelModel>
    implements $UserLevelModelCopyWith<$Res> {
  _$UserLevelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserLevelModel
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
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserLevelModelImplCopyWith<$Res>
    implements $UserLevelModelCopyWith<$Res> {
  factory _$$UserLevelModelImplCopyWith(
    _$UserLevelModelImpl value,
    $Res Function(_$UserLevelModelImpl) then,
  ) = __$$UserLevelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'current_xp') int currentXp,
    int level,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class __$$UserLevelModelImplCopyWithImpl<$Res>
    extends _$UserLevelModelCopyWithImpl<$Res, _$UserLevelModelImpl>
    implements _$$UserLevelModelImplCopyWith<$Res> {
  __$$UserLevelModelImplCopyWithImpl(
    _$UserLevelModelImpl _value,
    $Res Function(_$UserLevelModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserLevelModel
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
      _$UserLevelModelImpl(
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
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLevelModelImpl extends _UserLevelModel {
  const _$UserLevelModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'current_xp') required this.currentXp,
    required this.level,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : super._();

  factory _$UserLevelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLevelModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'current_xp')
  final int currentXp;
  @override
  final int level;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @override
  String toString() {
    return 'UserLevelModel(userId: $userId, currentXp: $currentXp, level: $level, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLevelModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentXp, currentXp) ||
                other.currentXp == currentXp) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, currentXp, level, updatedAt);

  /// Create a copy of UserLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLevelModelImplCopyWith<_$UserLevelModelImpl> get copyWith =>
      __$$UserLevelModelImplCopyWithImpl<_$UserLevelModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLevelModelImplToJson(this);
  }
}

abstract class _UserLevelModel extends UserLevelModel {
  const factory _UserLevelModel({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'current_xp') required final int currentXp,
    required final int level,
    @JsonKey(name: 'updated_at') required final String updatedAt,
  }) = _$UserLevelModelImpl;
  const _UserLevelModel._() : super._();

  factory _UserLevelModel.fromJson(Map<String, dynamic> json) =
      _$UserLevelModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'current_xp')
  int get currentXp;
  @override
  int get level;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of UserLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLevelModelImplCopyWith<_$UserLevelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
