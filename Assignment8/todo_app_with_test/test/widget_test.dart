// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todoappwithtest/main.dart';

void main() {
  testWidgets('Todo application test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    final sampleTodoText = "Test todo item 1";

    // Verify our sampleTodoText doesn't exist yet.
    expect(find.text(sampleTodoText), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter sampleTodoText into text field and tap back.
    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(TextField), sampleTodoText);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // Verify that sampleTodoText has been added.
    expect(find.text(sampleTodoText), findsOneWidget);
  });
}
