import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/domain/entities/auth_state.dart' as app;
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';
import 'package:running_mate/features/auth/domain/entities/user_profile.dart';
import 'package:running_mate/features/auth/domain/repositories/auth_repository.dart';
import 'package:running_mate/features/auth/presentation/providers/auth_providers.dart';
import 'package:running_mate/features/auth/presentation/screens/onboarding_screen.dart';

/// Mock AuthRepository for testing
class MockAuthRepository implements AuthRepository {
  @override
  Stream<app.AuthState> get authStateStream => const Stream.empty();

  @override
  UserProfile? get currentUser => null;

  @override
  bool get isLoggedIn => false;

  @override
  Future<UserProfile> signInWithProvider(AuthProvider provider) async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<UserProfile?> getProfile(String userId) async => null;

  @override
  Future<UserProfile> updateProfile(UserProfile profile) async => profile;

  @override
  Future<bool> isNicknameAvailable(String nickname) async => true;

  @override
  Future<void> requestAccountDeletion() async {}

  @override
  Future<void> cancelAccountDeletion() async {}

  @override
  Future<app.AuthState> checkAuthState() async => app.AuthState.initial;
}

void main() {
  group('OnboardingScreen', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should display nickname step initially', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('닉네임을 알려주세요'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should display step indicator', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('should show next button', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('다음'), findsOneWidget);
    });
  });
}
