import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/services/level_calculator.dart';

void main() {
  group('LevelCalculator', () {
    group('getRequiredXp', () {
      test('should return 0 for level 1', () {
        expect(LevelCalculator.getRequiredXp(1), 0);
      });

      test('should return correct XP for levels 2-5', () {
        expect(LevelCalculator.getRequiredXp(2), 100);
        expect(LevelCalculator.getRequiredXp(3), 200);
        expect(LevelCalculator.getRequiredXp(4), 300);
        expect(LevelCalculator.getRequiredXp(5), 400);
      });

      test('should return correct XP for levels 6+', () {
        expect(LevelCalculator.getRequiredXp(6), 900);
        expect(LevelCalculator.getRequiredXp(7), 1400);
        expect(LevelCalculator.getRequiredXp(10), 2900);
      });
    });

    group('getLevelForXp', () {
      test('should return level 1 for 0 XP', () {
        expect(LevelCalculator.getLevelForXp(0), 1);
      });

      test('should return correct level for XP', () {
        expect(LevelCalculator.getLevelForXp(50), 1);
        expect(LevelCalculator.getLevelForXp(100), 2);
        expect(LevelCalculator.getLevelForXp(199), 2);
        expect(LevelCalculator.getLevelForXp(200), 3);
        expect(LevelCalculator.getLevelForXp(899), 5);
        expect(LevelCalculator.getLevelForXp(900), 6);
      });
    });

    group('getLevelName', () {
      test('should return correct names for levels 1-10', () {
        expect(LevelCalculator.getLevelName(1), '새싹 러너');
        expect(LevelCalculator.getLevelName(5), '러너');
        expect(LevelCalculator.getLevelName(10), '레전드 러너');
      });

      test('should return roman numeral suffix for levels 11+', () {
        expect(LevelCalculator.getLevelName(11), '레전드 러너 II');
        expect(LevelCalculator.getLevelName(12), '레전드 러너 III');
      });
    });
  });
}
