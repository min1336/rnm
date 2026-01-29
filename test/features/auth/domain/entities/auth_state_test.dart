import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/domain/entities/auth_state.dart';

void main() {
  group('AuthState', () {
    test('should have initial state', () {
      expect(AuthState.initial.name, 'initial');
    });

    test('should have unauthenticated state', () {
      expect(AuthState.unauthenticated.name, 'unauthenticated');
    });

    test('should have needsOnboarding state', () {
      expect(AuthState.needsOnboarding.name, 'needsOnboarding');
    });

    test('should have authenticated state', () {
      expect(AuthState.authenticated.name, 'authenticated');
    });
  });
}
