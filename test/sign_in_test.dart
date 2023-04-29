// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

 import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booksgrid/screens/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  group('Email Field Validator', () {
    late TextEditingController emailController;
    late String? Function(String?) emailValidator;

    setUp(() {
      emailController = TextEditingController();
      emailValidator = LoginScreenState().emailValidator;
    });

    test('empty email returns error message', () {
      final String? result = emailValidator('');
      expect(result, 'Enter Your Email address');
    });

    test('invalid email returns error message', () {
      final String? result = emailValidator('invalid_email');
      expect(result, 'Enter a valid email address');
    });

    test('valid email returns null', () {
      final String? result = emailValidator('test@example.com');
      expect(result, null);
    });

    tearDown(() {
      emailController.dispose();
    });
  });

  group('Password Field Validator', () {
    late TextEditingController passwordController;
    late String? Function(String?) passwordValidator;

    setUp(() {
      passwordController = TextEditingController();
      passwordValidator = LoginScreenState().passwordValidator;
    });

    test('empty password returns error message', () {
      final String? result = passwordValidator('');
      expect(result, 'Password is required');
    });

    test('password with less than 6 characters returns error message', () {
      final String? result = passwordValidator('12345');
      expect(result, 'Enter Valid Password');
    });

    test('valid password returns null', () {
      final String? result = passwordValidator('password');
      expect(result, null);
    });

    tearDown(() {
      passwordController.dispose();
    });
  });
}
