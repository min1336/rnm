// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaderboardEntryModel _$LeaderboardEntryModelFromJson(
  Map<String, dynamic> json,
) {
  return _LeaderboardEntryModel.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardEntryModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_distance')
  double get totalDistance => throw _privateConstructorUsedError;
  @JsonKey(name: 'run_count')
  int get runCount => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardEntryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardEntryModelCopyWith<LeaderboardEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardEntryModelCopyWith<$Res> {
  factory $LeaderboardEntryModelCopyWith(
    LeaderboardEntryModel value,
    $Res Function(LeaderboardEntryModel) then,
  ) = _$LeaderboardEntryModelCopyWithImpl<$Res, LeaderboardEntryModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'display_name') String displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'total_distance') double totalDistance,
    @JsonKey(name: 'run_count') int runCount,
    int rank,
  });
}

/// @nodoc
class _$LeaderboardEntryModelCopyWithImpl<
  $Res,
  $Val extends LeaderboardEntryModel
>
    implements $LeaderboardEntryModelCopyWith<$Res> {
  _$LeaderboardEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? totalDistance = null,
    Object? runCount = null,
    Object? rank = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalDistance: null == totalDistance
                ? _value.totalDistance
                : totalDistance // ignore: cast_nullable_to_non_nullable
                      as double,
            runCount: null == runCount
                ? _value.runCount
                : runCount // ignore: cast_nullable_to_non_nullable
                      as int,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaderboardEntryModelImplCopyWith<$Res>
    implements $LeaderboardEntryModelCopyWith<$Res> {
  factory _$$LeaderboardEntryModelImplCopyWith(
    _$LeaderboardEntryModelImpl value,
    $Res Function(_$LeaderboardEntryModelImpl) then,
  ) = __$$LeaderboardEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'display_name') String displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'total_distance') double totalDistance,
    @JsonKey(name: 'run_count') int runCount,
    int rank,
  });
}

/// @nodoc
class __$$LeaderboardEntryModelImplCopyWithImpl<$Res>
    extends
        _$LeaderboardEntryModelCopyWithImpl<$Res, _$LeaderboardEntryModelImpl>
    implements _$$LeaderboardEntryModelImplCopyWith<$Res> {
  __$$LeaderboardEntryModelImplCopyWithImpl(
    _$LeaderboardEntryModelImpl _value,
    $Res Function(_$LeaderboardEntryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? totalDistance = null,
    Object? runCount = null,
    Object? rank = null,
  }) {
    return _then(
      _$LeaderboardEntryModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalDistance: null == totalDistance
            ? _value.totalDistance
            : totalDistance // ignore: cast_nullable_to_non_nullable
                  as double,
        runCount: null == runCount
            ? _value.runCount
            : runCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardEntryModelImpl extends _LeaderboardEntryModel {
  const _$LeaderboardEntryModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'display_name') required this.displayName,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'total_distance') required this.totalDistance,
    @JsonKey(name: 'run_count') required this.runCount,
    required this.rank,
  }) : super._();

  factory _$LeaderboardEntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardEntryModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'total_distance')
  final double totalDistance;
  @override
  @JsonKey(name: 'run_count')
  final int runCount;
  @override
  final int rank;

  @override
  String toString() {
    return 'LeaderboardEntryModel(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, totalDistance: $totalDistance, runCount: $runCount, rank: $rank)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardEntryModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.runCount, runCount) ||
                other.runCount == runCount) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    displayName,
    avatarUrl,
    totalDistance,
    runCount,
    rank,
  );

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardEntryModelImplCopyWith<_$LeaderboardEntryModelImpl>
  get copyWith =>
      __$$LeaderboardEntryModelImplCopyWithImpl<_$LeaderboardEntryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardEntryModelImplToJson(this);
  }
}

abstract class _LeaderboardEntryModel extends LeaderboardEntryModel {
  const factory _LeaderboardEntryModel({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'display_name') required final String displayName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'total_distance') required final double totalDistance,
    @JsonKey(name: 'run_count') required final int runCount,
    required final int rank,
  }) = _$LeaderboardEntryModelImpl;
  const _LeaderboardEntryModel._() : super._();

  factory _LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =
      _$LeaderboardEntryModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'display_name')
  String get displayName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'total_distance')
  double get totalDistance;
  @override
  @JsonKey(name: 'run_count')
  int get runCount;
  @override
  int get rank;

  /// Create a copy of LeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardEntryModelImplCopyWith<_$LeaderboardEntryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
