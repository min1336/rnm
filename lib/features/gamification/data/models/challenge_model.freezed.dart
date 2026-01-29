// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) {
  return _ChallengeModel.fromJson(json);
}

/// @nodoc
mixin _$ChallengeModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_value')
  int get targetValue => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'xp_reward')
  int get xpReward => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_at')
  String get startAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_at')
  String get endAt => throw _privateConstructorUsedError;

  /// Serializes this ChallengeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeModelCopyWith<ChallengeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeModelCopyWith<$Res> {
  factory $ChallengeModelCopyWith(
    ChallengeModel value,
    $Res Function(ChallengeModel) then,
  ) = _$ChallengeModelCopyWithImpl<$Res, ChallengeModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String type,
    @JsonKey(name: 'target_value') int targetValue,
    String unit,
    @JsonKey(name: 'xp_reward') int xpReward,
    @JsonKey(name: 'start_at') String startAt,
    @JsonKey(name: 'end_at') String endAt,
  });
}

/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res, $Val extends ChallengeModel>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? targetValue = null,
    Object? unit = null,
    Object? xpReward = null,
    Object? startAt = null,
    Object? endAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            targetValue: null == targetValue
                ? _value.targetValue
                : targetValue // ignore: cast_nullable_to_non_nullable
                      as int,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            xpReward: null == xpReward
                ? _value.xpReward
                : xpReward // ignore: cast_nullable_to_non_nullable
                      as int,
            startAt: null == startAt
                ? _value.startAt
                : startAt // ignore: cast_nullable_to_non_nullable
                      as String,
            endAt: null == endAt
                ? _value.endAt
                : endAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeModelImplCopyWith<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  factory _$$ChallengeModelImplCopyWith(
    _$ChallengeModelImpl value,
    $Res Function(_$ChallengeModelImpl) then,
  ) = __$$ChallengeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String type,
    @JsonKey(name: 'target_value') int targetValue,
    String unit,
    @JsonKey(name: 'xp_reward') int xpReward,
    @JsonKey(name: 'start_at') String startAt,
    @JsonKey(name: 'end_at') String endAt,
  });
}

/// @nodoc
class __$$ChallengeModelImplCopyWithImpl<$Res>
    extends _$ChallengeModelCopyWithImpl<$Res, _$ChallengeModelImpl>
    implements _$$ChallengeModelImplCopyWith<$Res> {
  __$$ChallengeModelImplCopyWithImpl(
    _$ChallengeModelImpl _value,
    $Res Function(_$ChallengeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? targetValue = null,
    Object? unit = null,
    Object? xpReward = null,
    Object? startAt = null,
    Object? endAt = null,
  }) {
    return _then(
      _$ChallengeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        targetValue: null == targetValue
            ? _value.targetValue
            : targetValue // ignore: cast_nullable_to_non_nullable
                  as int,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        xpReward: null == xpReward
            ? _value.xpReward
            : xpReward // ignore: cast_nullable_to_non_nullable
                  as int,
        startAt: null == startAt
            ? _value.startAt
            : startAt // ignore: cast_nullable_to_non_nullable
                  as String,
        endAt: null == endAt
            ? _value.endAt
            : endAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeModelImpl extends _ChallengeModel {
  const _$ChallengeModelImpl({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    @JsonKey(name: 'target_value') required this.targetValue,
    required this.unit,
    @JsonKey(name: 'xp_reward') required this.xpReward,
    @JsonKey(name: 'start_at') required this.startAt,
    @JsonKey(name: 'end_at') required this.endAt,
  }) : super._();

  factory _$ChallengeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String type;
  @override
  @JsonKey(name: 'target_value')
  final int targetValue;
  @override
  final String unit;
  @override
  @JsonKey(name: 'xp_reward')
  final int xpReward;
  @override
  @JsonKey(name: 'start_at')
  final String startAt;
  @override
  @JsonKey(name: 'end_at')
  final String endAt;

  @override
  String toString() {
    return 'ChallengeModel(id: $id, title: $title, description: $description, type: $type, targetValue: $targetValue, unit: $unit, xpReward: $xpReward, startAt: $startAt, endAt: $endAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    type,
    targetValue,
    unit,
    xpReward,
    startAt,
    endAt,
  );

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      __$$ChallengeModelImplCopyWithImpl<_$ChallengeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeModelImplToJson(this);
  }
}

abstract class _ChallengeModel extends ChallengeModel {
  const factory _ChallengeModel({
    required final String id,
    required final String title,
    final String? description,
    required final String type,
    @JsonKey(name: 'target_value') required final int targetValue,
    required final String unit,
    @JsonKey(name: 'xp_reward') required final int xpReward,
    @JsonKey(name: 'start_at') required final String startAt,
    @JsonKey(name: 'end_at') required final String endAt,
  }) = _$ChallengeModelImpl;
  const _ChallengeModel._() : super._();

  factory _ChallengeModel.fromJson(Map<String, dynamic> json) =
      _$ChallengeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get type;
  @override
  @JsonKey(name: 'target_value')
  int get targetValue;
  @override
  String get unit;
  @override
  @JsonKey(name: 'xp_reward')
  int get xpReward;
  @override
  @JsonKey(name: 'start_at')
  String get startAt;
  @override
  @JsonKey(name: 'end_at')
  String get endAt;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserChallengeModel _$UserChallengeModelFromJson(Map<String, dynamic> json) {
  return _UserChallengeModel.fromJson(json);
}

/// @nodoc
mixin _$UserChallengeModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'challenge_id')
  String get challengeId => throw _privateConstructorUsedError;
  ChallengeModel get challenge => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_progress')
  int get currentProgress => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_completed')
  bool get isCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  String? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  String get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this UserChallengeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserChallengeModelCopyWith<UserChallengeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChallengeModelCopyWith<$Res> {
  factory $UserChallengeModelCopyWith(
    UserChallengeModel value,
    $Res Function(UserChallengeModel) then,
  ) = _$UserChallengeModelCopyWithImpl<$Res, UserChallengeModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'challenge_id') String challengeId,
    ChallengeModel challenge,
    @JsonKey(name: 'current_progress') int currentProgress,
    @JsonKey(name: 'is_completed') bool isCompleted,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'joined_at') String joinedAt,
  });

  $ChallengeModelCopyWith<$Res> get challenge;
}

/// @nodoc
class _$UserChallengeModelCopyWithImpl<$Res, $Val extends UserChallengeModel>
    implements $UserChallengeModelCopyWith<$Res> {
  _$UserChallengeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? challengeId = null,
    Object? challenge = null,
    Object? currentProgress = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            challengeId: null == challengeId
                ? _value.challengeId
                : challengeId // ignore: cast_nullable_to_non_nullable
                      as String,
            challenge: null == challenge
                ? _value.challenge
                : challenge // ignore: cast_nullable_to_non_nullable
                      as ChallengeModel,
            currentProgress: null == currentProgress
                ? _value.currentProgress
                : currentProgress // ignore: cast_nullable_to_non_nullable
                      as int,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of UserChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChallengeModelCopyWith<$Res> get challenge {
    return $ChallengeModelCopyWith<$Res>(_value.challenge, (value) {
      return _then(_value.copyWith(challenge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserChallengeModelImplCopyWith<$Res>
    implements $UserChallengeModelCopyWith<$Res> {
  factory _$$UserChallengeModelImplCopyWith(
    _$UserChallengeModelImpl value,
    $Res Function(_$UserChallengeModelImpl) then,
  ) = __$$UserChallengeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'challenge_id') String challengeId,
    ChallengeModel challenge,
    @JsonKey(name: 'current_progress') int currentProgress,
    @JsonKey(name: 'is_completed') bool isCompleted,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'joined_at') String joinedAt,
  });

  @override
  $ChallengeModelCopyWith<$Res> get challenge;
}

/// @nodoc
class __$$UserChallengeModelImplCopyWithImpl<$Res>
    extends _$UserChallengeModelCopyWithImpl<$Res, _$UserChallengeModelImpl>
    implements _$$UserChallengeModelImplCopyWith<$Res> {
  __$$UserChallengeModelImplCopyWithImpl(
    _$UserChallengeModelImpl _value,
    $Res Function(_$UserChallengeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? challengeId = null,
    Object? challenge = null,
    Object? currentProgress = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _$UserChallengeModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        challengeId: null == challengeId
            ? _value.challengeId
            : challengeId // ignore: cast_nullable_to_non_nullable
                  as String,
        challenge: null == challenge
            ? _value.challenge
            : challenge // ignore: cast_nullable_to_non_nullable
                  as ChallengeModel,
        currentProgress: null == currentProgress
            ? _value.currentProgress
            : currentProgress // ignore: cast_nullable_to_non_nullable
                  as int,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChallengeModelImpl extends _UserChallengeModel {
  const _$UserChallengeModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'challenge_id') required this.challengeId,
    required this.challenge,
    @JsonKey(name: 'current_progress') required this.currentProgress,
    @JsonKey(name: 'is_completed') required this.isCompleted,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(name: 'joined_at') required this.joinedAt,
  }) : super._();

  factory _$UserChallengeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserChallengeModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'challenge_id')
  final String challengeId;
  @override
  final ChallengeModel challenge;
  @override
  @JsonKey(name: 'current_progress')
  final int currentProgress;
  @override
  @JsonKey(name: 'is_completed')
  final bool isCompleted;
  @override
  @JsonKey(name: 'completed_at')
  final String? completedAt;
  @override
  @JsonKey(name: 'joined_at')
  final String joinedAt;

  @override
  String toString() {
    return 'UserChallengeModel(userId: $userId, challengeId: $challengeId, challenge: $challenge, currentProgress: $currentProgress, isCompleted: $isCompleted, completedAt: $completedAt, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChallengeModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.currentProgress, currentProgress) ||
                other.currentProgress == currentProgress) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    challengeId,
    challenge,
    currentProgress,
    isCompleted,
    completedAt,
    joinedAt,
  );

  /// Create a copy of UserChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChallengeModelImplCopyWith<_$UserChallengeModelImpl> get copyWith =>
      __$$UserChallengeModelImplCopyWithImpl<_$UserChallengeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChallengeModelImplToJson(this);
  }
}

abstract class _UserChallengeModel extends UserChallengeModel {
  const factory _UserChallengeModel({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'challenge_id') required final String challengeId,
    required final ChallengeModel challenge,
    @JsonKey(name: 'current_progress') required final int currentProgress,
    @JsonKey(name: 'is_completed') required final bool isCompleted,
    @JsonKey(name: 'completed_at') final String? completedAt,
    @JsonKey(name: 'joined_at') required final String joinedAt,
  }) = _$UserChallengeModelImpl;
  const _UserChallengeModel._() : super._();

  factory _UserChallengeModel.fromJson(Map<String, dynamic> json) =
      _$UserChallengeModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'challenge_id')
  String get challengeId;
  @override
  ChallengeModel get challenge;
  @override
  @JsonKey(name: 'current_progress')
  int get currentProgress;
  @override
  @JsonKey(name: 'is_completed')
  bool get isCompleted;
  @override
  @JsonKey(name: 'completed_at')
  String? get completedAt;
  @override
  @JsonKey(name: 'joined_at')
  String get joinedAt;

  /// Create a copy of UserChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserChallengeModelImplCopyWith<_$UserChallengeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
