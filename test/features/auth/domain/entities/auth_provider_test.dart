import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';

void main() {
  group('AuthProvider', () {
    test('should have google provider', () {
      expect(AuthProvider.google.name, 'google');
    });

    test('should have apple provider', () {
      expect(AuthProvider.apple.name, 'apple');
    });

    test('should have kakao provider', () {
      expect(AuthProvider.kakao.name, 'kakao');
    });
  });
}
