import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/domain/entities/running_goal.dart';

void main() {
  group('RunningGoal', () {
    test('should have marathon goal with correct label', () {
      expect(RunningGoal.marathon.label, '마라톤 완주');
    });

    test('should have diet goal with correct label', () {
      expect(RunningGoal.diet.label, '다이어트');
    });

    test('should have fitness goal with correct label', () {
      expect(RunningGoal.fitness.label, '체력 향상');
    });

    test('should have stress goal with correct label', () {
      expect(RunningGoal.stress.label, '스트레스 해소');
    });
  });
}
