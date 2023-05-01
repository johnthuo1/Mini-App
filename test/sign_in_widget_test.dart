// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booksgrid/screens/sign_in.dart';
import 'package:booksgrid/main.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('Sign in page test', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(LoginScreen());

    // Find the text fields and buttons by their keys
    final emailField = find.byKey(Key('Email'));
    final passwordField = find.byKey(Key('Password'));
    final logInButton = find.byKey(Key('Login'));

    // Verify that the widgets are present
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(logInButton, findsOneWidget);

    // Enter some text into the fields
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');

    // Tap the sign in button
    await tester.tap(logInButton);

    // Wait for the page to rebuild
    await tester.pumpAndSettle();

    // Verify that the sign in page is replaced by the home page
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
