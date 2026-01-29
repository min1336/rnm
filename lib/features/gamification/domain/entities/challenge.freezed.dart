// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Challenge {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  ChallengeType get type => throw _privateConstructorUsedError;
  int get targetValue => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  DateTime get startAt => throw _privateConstructorUsedError;
  DateTime get endAt => throw _privateConstructorUsedError;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeCopyWith<Challenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCopyWith<$Res> {
  factory $ChallengeCopyWith(Challenge value, $Res Function(Challenge) then) =
      _$ChallengeCopyWithImpl<$Res, Challenge>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    ChallengeType type,
    int targetValue,
    String unit,
    int xpReward,
    DateTime startAt,
    DateTime endAt,
  });
}

/// @nodoc
class _$ChallengeCopyWithImpl<$Res, $Val extends Challenge>
    implements $ChallengeCopyWith<$Res> {
  _$ChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Challenge
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
                      as ChallengeType,
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
                      as DateTime,
            endAt: null == endAt
                ? _value.endAt
                : endAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
    _$ChallengeImpl value,
    $Res Function(_$ChallengeImpl) then,
  ) = __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    ChallengeType type,
    int targetValue,
    String unit,
    int xpReward,
    DateTime startAt,
    DateTime endAt,
  });
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
    _$ChallengeImpl _value,
    $Res Function(_$ChallengeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Challenge
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
      _$ChallengeImpl(
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
                  as ChallengeType,
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
                  as DateTime,
        endAt: null == endAt
            ? _value.endAt
            : endAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.targetValue,
    required this.unit,
    required this.xpReward,
    required this.startAt,
    required this.endAt,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final ChallengeType type;
  @override
  final int targetValue;
  @override
  final String unit;
  @override
  final int xpReward;
  @override
  final DateTime startAt;
  @override
  final DateTime endAt;

  @override
  String toString() {
    return 'Challenge(id: $id, title: $title, description: $description, type: $type, targetValue: $targetValue, unit: $unit, xpReward: $xpReward, startAt: $startAt, endAt: $endAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
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

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);
}

abstract class _Challenge implements Challenge {
  const factory _Challenge({
    required final String id,
    required final String title,
    final String? description,
    required final ChallengeType type,
    required final int targetValue,
    required final String unit,
    required final int xpReward,
    required final DateTime startAt,
    required final DateTime endAt,
  }) = _$ChallengeImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  ChallengeType get type;
  @override
  int get targetValue;
  @override
  String get unit;
  @override
  int get xpReward;
  @override
  DateTime get startAt;
  @override
  DateTime get endAt;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserChallenge {
  String get userId => throw _privateConstructorUsedError;
  String get challengeId => throw _privateConstructorUsedError;
  Challenge get challenge => throw _privateConstructorUsedError;
  int get currentProgress => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserChallengeCopyWith<UserChallenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChallengeCopyWith<$Res> {
  factory $UserChallengeCopyWith(
    UserChallenge value,
    $Res Function(UserChallenge) then,
  ) = _$UserChallengeCopyWithImpl<$Res, UserChallenge>;
  @useResult
  $Res call({
    String userId,
    String challengeId,
    Challenge challenge,
    int currentProgress,
    bool isCompleted,
    DateTime? completedAt,
    DateTime joinedAt,
  });

  $ChallengeCopyWith<$Res> get challenge;
}

/// @nodoc
class _$UserChallengeCopyWithImpl<$Res, $Val extends UserChallenge>
    implements $UserChallengeCopyWith<$Res> {
  _$UserChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserChallenge
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
                      as Challenge,
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
                      as DateTime?,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChallengeCopyWith<$Res> get challenge {
    return $ChallengeCopyWith<$Res>(_value.challenge, (value) {
      return _then(_value.copyWith(challenge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserChallengeImplCopyWith<$Res>
    implements $UserChallengeCopyWith<$Res> {
  factory _$$UserChallengeImplCopyWith(
    _$UserChallengeImpl value,
    $Res Function(_$UserChallengeImpl) then,
  ) = __$$UserChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String challengeId,
    Challenge challenge,
    int currentProgress,
    bool isCompleted,
    DateTime? completedAt,
    DateTime joinedAt,
  });

  @override
  $ChallengeCopyWith<$Res> get challenge;
}

/// @nodoc
class __$$UserChallengeImplCopyWithImpl<$Res>
    extends _$UserChallengeCopyWithImpl<$Res, _$UserChallengeImpl>
    implements _$$UserChallengeImplCopyWith<$Res> {
  __$$UserChallengeImplCopyWithImpl(
    _$UserChallengeImpl _value,
    $Res Function(_$UserChallengeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserChallenge
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
      _$UserChallengeImpl(
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
                  as Challenge,
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
                  as DateTime?,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$UserChallengeImpl extends _UserChallenge {
  const _$UserChallengeImpl({
    required this.userId,
    required this.challengeId,
    required this.challenge,
    required this.currentProgress,
    required this.isCompleted,
    this.completedAt,
    required this.joinedAt,
  }) : super._();

  @override
  final String userId;
  @override
  final String challengeId;
  @override
  final Challenge challenge;
  @override
  final int currentProgress;
  @override
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final DateTime joinedAt;

  @override
  String toString() {
    return 'UserChallenge(userId: $userId, challengeId: $challengeId, challenge: $challenge, currentProgress: $currentProgress, isCompleted: $isCompleted, completedAt: $completedAt, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChallengeImpl &&
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

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChallengeImplCopyWith<_$UserChallengeImpl> get copyWith =>
      __$$UserChallengeImplCopyWithImpl<_$UserChallengeImpl>(this, _$identity);
}

abstract class _UserChallenge extends UserChallenge {
  const factory _UserChallenge({
    required final String userId,
    required final String challengeId,
    required final Challenge challenge,
    required final int currentProgress,
    required final bool isCompleted,
    final DateTime? completedAt,
    required final DateTime joinedAt,
  }) = _$UserChallengeImpl;
  const _UserChallenge._() : super._();

  @override
  String get userId;
  @override
  String get challengeId;
  @override
  Challenge get challenge;
  @override
  int get currentProgress;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  DateTime get joinedAt;

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserChallengeImplCopyWith<_$UserChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
