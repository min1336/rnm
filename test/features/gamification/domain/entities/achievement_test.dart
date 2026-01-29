import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/achievement.dart';

void main() {
  group('Achievement', () {
    test('should create Achievement with all fields', () {
      final achievement = Achievement(
        id: 'first_step',
        name: '첫 발걸음',
        description: '첫 러닝을 완료했습니다',
        iconName: 'footprints',
        category: AchievementCategory.distance,
        conditionType: ConditionType.firstRun,
        conditionValue: 1,
        xpReward: 50,
      );

      expect(achievement.id, 'first_step');
      expect(achievement.xpReward, 50);
      expect(achievement.category, AchievementCategory.distance);
    });
  });

  group('UserAchievement', () {
    test('should create UserAchievement with achievement', () {
      final achievement = Achievement(
        id: 'first_step',
        name: '첫 발걸음',
        description: '첫 러닝을 완료했습니다',
        iconName: 'footprints',
        category: AchievementCategory.distance,
        conditionType: ConditionType.firstRun,
        conditionValue: 1,
        xpReward: 50,
      );

      final userAchievement = UserAchievement(
        userId: 'user-1',
        achievementId: 'first_step',
        achievement: achievement,
        unlockedAt: DateTime(2026, 1, 29),
      );

      expect(userAchievement.userId, 'user-1');
      expect(userAchievement.achievement.name, '첫 발걸음');
    });
  });
}
