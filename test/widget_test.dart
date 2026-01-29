import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/app/app.dart';

void main() {
  testWidgets('App loads and shows home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the home screen is displayed
    expect(find.text('RunningMate'), findsOneWidget);
    expect(find.text('Start Run'), findsOneWidget);
  });
}
