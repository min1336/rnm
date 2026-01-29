import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';
import 'package:running_mate/features/auth/domain/entities/user_profile.dart';
import 'package:running_mate/features/auth/domain/repositories/auth_repository.dart';
import 'package:running_mate/features/auth/domain/usecases/sign_in_with_social.dart';

import 'sign_in_with_social_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignInWithSocial useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInWithSocial(mockRepository);
  });

  group('SignInWithSocial', () {
    final testProfile = UserProfile(
      id: 'user-123',
      email: 'test@example.com',
      provider: AuthProvider.google,
      createdAt: DateTime(2026, 1, 29),
    );

    test('should call repository signInWithProvider', () async {
      when(mockRepository.signInWithProvider(AuthProvider.google))
          .thenAnswer((_) async => testProfile);

      final result = await useCase(AuthProvider.google);

      expect(result, testProfile);
      verify(mockRepository.signInWithProvider(AuthProvider.google)).called(1);
    });

    test('should work with different providers', () async {
      when(mockRepository.signInWithProvider(AuthProvider.apple))
          .thenAnswer((_) async => testProfile.copyWith(provider: AuthProvider.apple));

      final result = await useCase(AuthProvider.apple);

      expect(result.provider, AuthProvider.apple);
    });
  });
}
