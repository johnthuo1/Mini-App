// ignore_for_file: prefer_const_constructors
import 'package:booksgrid/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booksgrid/screens/sign_up.dart';

void main() {
   
  // When all sign up details are filled in correctly
  testWidgets(
    'Test sign up with all required fields and Terms and Conditions checked',
    (WidgetTester tester) async {
      // Build the sign up page widget
      await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

      // Enter a valid username
      await tester.enterText(find.byKey(Key('userNameField')), 'test_user');

      // Enter a valid email address
      await tester.enterText(
        find.byKey(Key('emailField')), 'test_user@example.com');

      // Enter a valid password
      await tester.enterText(find.byKey(Key('passwordField')), 'test_password');

      // Enter the same password in the confirmation field
      await tester.enterText(
        find.byKey(Key('confirmPasswordField')), 'test_password');

      // Check the Terms and Conditions checkbox
      await tester.tap(find.byKey(Key('TermsAndConditionsCheckbox')));

      // Submit the form by tapping the sign up button
      await tester.tap(find.byType(ElevatedButton));

      // Wait for the sign-up process to complete
      await tester.pumpAndSettle();

      // Verify that the sign-up was successful
      expect(find.text('Account created successfully :) '), findsOneWidget);

      // User is directed to the Home Screen after successful Sign Up
      expect(find.byType(HomePage), findsOneWidget);

    },
  );


  // Testing with invalid details
  testWidgets(
    'Test sign up with invalid password',
    (WidgetTester tester) async {
      // Build the sign up page widget
      await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

      // Enter a valid username
      await tester.enterText(find.byKey(Key('userNameField')), 'test_user');

      // Enter a valid email address
      await tester.enterText(
        find.byKey(Key('emailField')), 'test_user@example.com');

      // Enter an invalid password (less than 8 characters)
      await tester.enterText(find.byKey(Key('passwordField')), 'test');

      // Enter the same password in the confirmation field
      await tester.enterText(
        find.byKey(Key('confirmPasswordField')), 'test');

      // Check the Terms and Conditions checkbox
      await tester.tap(find.byKey(Key('TermsAndConditionsCheckbox')));

      // Submit the form by tapping the sign up button
      await tester.tap(find.byType(ElevatedButton));

      // Wait for the sign-up process to complete
      await tester.pumpAndSettle();

      // Verify that the sign-up failed due to an invalid password
      expect(find.text('Password must be at least 6 characters long.'), findsOneWidget);
    },
  );
}
