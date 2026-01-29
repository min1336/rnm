import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_level.dart';

void main() {
  group('UserLevel', () {
    test('should calculate progress percent correctly', () {
      final level = UserLevel(
        userId: 'user-1',
        currentXp: 150,
        level: 2,
        updatedAt: DateTime.now(),
      );

      // Level 2: 100 XP, Level 3: 200 XP
      // Progress: (150-100)/(200-100) = 50/100 = 0.5
      expect(level.xpForCurrentLevel, 100);
      expect(level.xpForNextLevel, 200);
      expect(level.xpProgress, 50);
      expect(level.progressPercent, 0.5);
    });

    test('should return correct level name', () {
      final level = UserLevel(
        userId: 'user-1',
        currentXp: 400,
        level: 5,
        updatedAt: DateTime.now(),
      );

      expect(level.levelName, '러너');
    });
  });
}
