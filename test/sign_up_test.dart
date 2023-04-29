// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booksgrid/screens/sign_up.dart';

void main() {
  testWidgets('Test sign up with all required fields and Terms and Conditions checked', (WidgetTester tester) async {
    // Build the sign up page widget
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Enter a valid username
    await tester.enterText(find.byKey(Key('userNameField')), 'test_user');

    // Enter a valid email address
    await tester.enterText(find.byKey(Key('emailField')), 'test_user@example.com');

    // Enter a valid password
    await tester.enterText(find.byKey(Key('passwordField')), 'test_password');

    // Enter the same password in the confirmation field
    await tester.enterText(find.byKey(Key('confirmPasswordField')), 'test_password');

    // Check the Terms and Conditions checkbox
    await tester.tap(find.byKey(Key('TermsAndConditionsCheckbox')));

    // Submit the form by tapping the sign up button
    await tester.tap(find.byType(ElevatedButton));

  });}

    
