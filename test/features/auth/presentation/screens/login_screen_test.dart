import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/auth/presentation/screens/login_screen.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('should display app title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      expect(find.text('RunningMate'), findsOneWidget);
    });

    testWidgets('should display all social login buttons', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      expect(find.text('Google로 계속하기'), findsOneWidget);
      expect(find.text('Apple로 계속하기'), findsOneWidget);
      expect(find.text('카카오로 계속하기'), findsOneWidget);
    });

    testWidgets('should display terms and privacy links', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      expect(find.text('이용약관'), findsOneWidget);
      expect(find.text('개인정보처리방침'), findsOneWidget);
    });
  });
}
