import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';

enum AchievementCategory {
  distance,
  streak,
  exploration,
  speed,
  time,
  special,
}

enum ConditionType {
  firstRun,
  totalDistance,
  streakDays,
  courseCount,
  courseShare,
  pace,
  earlyRunCount,
  nightRunCount,
  singleDistance,
  weekendStreak,
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String name,
    required String description,
    required String iconName,
    required AchievementCategory category,
    required ConditionType conditionType,
    required int conditionValue,
    required int xpReward,
  }) = _Achievement;
}

@freezed
class UserAchievement with _$UserAchievement {
  const factory UserAchievement({
    required String userId,
    required String achievementId,
    required Achievement achievement,
    required DateTime unlockedAt,
  }) = _UserAchievement;
}
