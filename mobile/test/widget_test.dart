// Basic widget tests for Axionyx Mobile

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axionyx_mobile/app.dart';

void main() {
  testWidgets('App should build without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: AxionyxApp()));

    // Verify that the home screen loads
    expect(find.text('My Devices'), findsOneWidget);
  });
}
