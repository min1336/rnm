import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/services/xp_calculator.dart';

void main() {
  late XpCalculator calculator;

  setUp(() {
    calculator = XpCalculator();
  });

  group('XpCalculator', () {
    test('should calculate run XP based on distance', () {
      expect(calculator.calculateRunXp(distanceKm: 5.0), 50);
      expect(calculator.calculateRunXp(distanceKm: 3.2), 32);
      expect(calculator.calculateRunXp(distanceKm: 10.5), 105);
    });

    test('should return 20 for first course bonus', () {
      expect(calculator.firstCourseBonus, 20);
    });
  });
}
