import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';

void main() {
  group('RunningContext', () {
    test('should have correct weight values for quick mode', () {
      final weights = RunningContext.quick.weights;

      expect(weights.distance, 0.5);
      expect(weights.difficulty, 0.2);
      expect(weights.goal, 0.1);
      expect(weights.popularity, 0.2);
    });

    test('should have correct weight values for training mode', () {
      final weights = RunningContext.training.weights;

      expect(weights.distance, 0.2);
      expect(weights.difficulty, 0.4);
      expect(weights.goal, 0.3);
      expect(weights.popularity, 0.1);
    });

    test('weights should sum to 1.0', () {
      for (final context in RunningContext.values) {
        final weights = context.weights;
        final sum = weights.distance + weights.difficulty + weights.goal + weights.popularity;
        expect(sum, closeTo(1.0, 0.001));
      }
    });
  });
}
