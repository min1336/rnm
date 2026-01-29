import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';
import 'package:running_mate/features/auth/presentation/widgets/social_login_button.dart';

void main() {
  group('SocialLoginButton', () {
    testWidgets('should display Google login button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.google,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Google로 계속하기'), findsOneWidget);
    });

    testWidgets('should display Apple login button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.apple,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Apple로 계속하기'), findsOneWidget);
    });

    testWidgets('should display Kakao login button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.kakao,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('카카오로 계속하기'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.google,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SocialLoginButton));
      expect(pressed, true);
    });

    testWidgets('should show loading indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.google,
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
