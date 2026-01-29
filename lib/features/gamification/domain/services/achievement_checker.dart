import '../entities/achievement.dart';
import '../entities/user_stats.dart';

class AchievementChecker {
  final List<Achievement> _allAchievements;

  AchievementChecker(this._allAchievements);

  List<Achievement> checkAfterRun({
    required UserStats stats,
    required double runDistanceKm,
    required double runPaceMinPerKm,
    required Set<String> unlockedIds,
  }) {
    final newAchievements = <Achievement>[];

    for (final achievement in _allAchievements) {
      if (unlockedIds.contains(achievement.id)) continue;

      if (_checkCondition(achievement, stats, runDistanceKm, runPaceMinPerKm)) {
        newAchievements.add(achievement);
      }
    }

    return newAchievements;
  }

  bool _checkCondition(
    Achievement a,
    UserStats stats,
    double runDistanceKm,
    double runPaceMinPerKm,
  ) {
    return switch (a.conditionType) {
      ConditionType.firstRun => stats.totalRuns == 1,
      ConditionType.totalDistance => stats.totalDistanceKm >= a.conditionValue,
      ConditionType.streakDays => stats.currentStreak >= a.conditionValue,
      ConditionType.courseCount => stats.uniqueCourseCount >= a.conditionValue,
      ConditionType.courseShare => stats.sharedCourseCount >= a.conditionValue,
      ConditionType.pace => runPaceMinPerKm <= a.conditionValue / 100,
      ConditionType.earlyRunCount => stats.earlyRunCount >= a.conditionValue,
      ConditionType.nightRunCount => stats.nightRunCount >= a.conditionValue,
      ConditionType.singleDistance => runDistanceKm >= a.conditionValue,
      ConditionType.weekendStreak => stats.weekendStreak >= a.conditionValue,
    };
  }
}
