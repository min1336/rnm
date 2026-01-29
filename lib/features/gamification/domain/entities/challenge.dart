import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge.freezed.dart';

enum ChallengeType { weekly, monthly, special }

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required String title,
    String? description,
    required ChallengeType type,
    required int targetValue,
    required String unit,
    required int xpReward,
    required DateTime startAt,
    required DateTime endAt,
  }) = _Challenge;
}

@freezed
class UserChallenge with _$UserChallenge {
  const UserChallenge._();

  const factory UserChallenge({
    required String userId,
    required String challengeId,
    required Challenge challenge,
    required int currentProgress,
    required bool isCompleted,
    DateTime? completedAt,
    required DateTime joinedAt,
  }) = _UserChallenge;

  double get progressPercent =>
      (currentProgress / challenge.targetValue).clamp(0.0, 1.0);

  bool get isExpired => DateTime.now().isAfter(challenge.endAt);
}
