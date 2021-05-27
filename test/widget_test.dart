// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:class_activity/main.dart';
import 'package:class_activity/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Password visibility toggle test', (WidgetTester tester) async {

    // Build app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap visibility icon
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();

    // Verify that our visibility has changed.
    expect(find.byIcon(Icons.visibility), findsNothing);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });

}
