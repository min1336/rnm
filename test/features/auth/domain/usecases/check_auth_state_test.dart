import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/auth/domain/entities/auth_state.dart';
import 'package:running_mate/features/auth/domain/repositories/auth_repository.dart';
import 'package:running_mate/features/auth/domain/usecases/check_auth_state.dart';

import 'check_auth_state_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late CheckAuthState useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = CheckAuthState(mockRepository);
  });

  group('CheckAuthState', () {
    test('should return unauthenticated when no session', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.unauthenticated);

      final result = await useCase();

      expect(result, AuthState.unauthenticated);
    });

    test('should return needsOnboarding when profile incomplete', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.needsOnboarding);

      final result = await useCase();

      expect(result, AuthState.needsOnboarding);
    });

    test('should return authenticated when fully authenticated', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.authenticated);

      final result = await useCase();

      expect(result, AuthState.authenticated);
    });
  });
}
