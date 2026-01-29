// lib/features/gamification/data/models/challenge_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/challenge.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const ChallengeModel._();

  const factory ChallengeModel({
    required String id,
    required String title,
    String? description,
    required String type,
    @JsonKey(name: 'target_value') required int targetValue,
    required String unit,
    @JsonKey(name: 'xp_reward') required int xpReward,
    @JsonKey(name: 'start_at') required String startAt,
    @JsonKey(name: 'end_at') required String endAt,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  Challenge toEntity() => Challenge(
        id: id,
        title: title,
        description: description,
        type: ChallengeType.values.firstWhere((t) => t.name == type),
        targetValue: targetValue,
        unit: unit,
        xpReward: xpReward,
        startAt: DateTime.parse(startAt),
        endAt: DateTime.parse(endAt),
      );
}

@freezed
class UserChallengeModel with _$UserChallengeModel {
  const UserChallengeModel._();

  const factory UserChallengeModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'challenge_id') required String challengeId,
    required ChallengeModel challenge,
    @JsonKey(name: 'current_progress') required int currentProgress,
    @JsonKey(name: 'is_completed') required bool isCompleted,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'joined_at') required String joinedAt,
  }) = _UserChallengeModel;

  factory UserChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$UserChallengeModelFromJson(json);

  UserChallenge toEntity() => UserChallenge(
        userId: userId,
        challengeId: challengeId,
        challenge: challenge.toEntity(),
        currentProgress: currentProgress,
        isCompleted: isCompleted,
        completedAt: completedAt != null ? DateTime.parse(completedAt!) : null,
        joinedAt: DateTime.parse(joinedAt),
      );
}
