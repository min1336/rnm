import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/app/app.dart';

void main() {
  // Skip: Integration test requires Supabase initialization
  // This test should be run as part of integration tests with proper setup
  // Skip: Integration test requires Supabase initialization
  // This test should be run as part of integration tests with proper setup
  testWidgets(
    'App shows loading indicator in initial state',
    skip: true, // Requires Supabase initialization - run as integration test
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: RunningMateApp(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
