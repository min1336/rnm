// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'weight_kg')
  double? get weightKg => throw _privateConstructorUsedError;
  String? get goal => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login_at')
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted')
  bool get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'deletion_requested_at')
  DateTime? get deletionRequestedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
    UserProfileModel value,
    $Res Function(UserProfileModel) then,
  ) = _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call({
    String id,
    String email,
    String? nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'weight_kg') double? weightKg,
    String? goal,
    String provider,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    @JsonKey(name: 'deletion_requested_at') DateTime? deletionRequestedAt,
  });
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = freezed,
    Object? avatarUrl = freezed,
    Object? weightKg = freezed,
    Object? goal = freezed,
    Object? provider = null,
    Object? createdAt = null,
    Object? lastLoginAt = freezed,
    Object? isDeleted = null,
    Object? deletionRequestedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            weightKg: freezed == weightKg
                ? _value.weightKg
                : weightKg // ignore: cast_nullable_to_non_nullable
                      as double?,
            goal: freezed == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as String?,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastLoginAt: freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            deletionRequestedAt: freezed == deletionRequestedAt
                ? _value.deletionRequestedAt
                : deletionRequestedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(
    _$UserProfileModelImpl value,
    $Res Function(_$UserProfileModelImpl) then,
  ) = __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String? nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'weight_kg') double? weightKg,
    String? goal,
    String provider,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    @JsonKey(name: 'deletion_requested_at') DateTime? deletionRequestedAt,
  });
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(
    _$UserProfileModelImpl _value,
    $Res Function(_$UserProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = freezed,
    Object? avatarUrl = freezed,
    Object? weightKg = freezed,
    Object? goal = freezed,
    Object? provider = null,
    Object? createdAt = null,
    Object? lastLoginAt = freezed,
    Object? isDeleted = null,
    Object? deletionRequestedAt = freezed,
  }) {
    return _then(
      _$UserProfileModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        weightKg: freezed == weightKg
            ? _value.weightKg
            : weightKg // ignore: cast_nullable_to_non_nullable
                  as double?,
        goal: freezed == goal
            ? _value.goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as String?,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastLoginAt: freezed == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        deletionRequestedAt: freezed == deletionRequestedAt
            ? _value.deletionRequestedAt
            : deletionRequestedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl extends _UserProfileModel {
  const _$UserProfileModelImpl({
    required this.id,
    required this.email,
    this.nickname,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'weight_kg') this.weightKg,
    this.goal,
    required this.provider,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'last_login_at') this.lastLoginAt,
    @JsonKey(name: 'is_deleted') this.isDeleted = false,
    @JsonKey(name: 'deletion_requested_at') this.deletionRequestedAt,
  }) : super._();

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? nickname;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'weight_kg')
  final double? weightKg;
  @override
  final String? goal;
  @override
  final String provider;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'last_login_at')
  final DateTime? lastLoginAt;
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @override
  @JsonKey(name: 'deletion_requested_at')
  final DateTime? deletionRequestedAt;

  @override
  String toString() {
    return 'UserProfileModel(id: $id, email: $email, nickname: $nickname, avatarUrl: $avatarUrl, weightKg: $weightKg, goal: $goal, provider: $provider, createdAt: $createdAt, lastLoginAt: $lastLoginAt, isDeleted: $isDeleted, deletionRequestedAt: $deletionRequestedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.deletionRequestedAt, deletionRequestedAt) ||
                other.deletionRequestedAt == deletionRequestedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    nickname,
    avatarUrl,
    weightKg,
    goal,
    provider,
    createdAt,
    lastLoginAt,
    isDeleted,
    deletionRequestedAt,
  );

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(this);
  }
}

abstract class _UserProfileModel extends UserProfileModel {
  const factory _UserProfileModel({
    required final String id,
    required final String email,
    final String? nickname,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'weight_kg') final double? weightKg,
    final String? goal,
    required final String provider,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'last_login_at') final DateTime? lastLoginAt,
    @JsonKey(name: 'is_deleted') final bool isDeleted,
    @JsonKey(name: 'deletion_requested_at') final DateTime? deletionRequestedAt,
  }) = _$UserProfileModelImpl;
  const _UserProfileModel._() : super._();

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get nickname;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'weight_kg')
  double? get weightKg;
  @override
  String? get goal;
  @override
  String get provider;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'last_login_at')
  DateTime? get lastLoginAt;
  @override
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;
  @override
  @JsonKey(name: 'deletion_requested_at')
  DateTime? get deletionRequestedAt;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
