// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:booksgrid/screens/upload_book.dart';

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  testWidgets('Title form field validation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BookUploadPage()));

    // Enter invalid title
    await tester.enterText(find.byKey(Key('title')), '');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify error message is displayed
    expect(find.text('Please enter the book title'), findsOneWidget);

    // Enter valid title
    await tester.enterText(find.byKey(Key('title')), 'How the Mighty Fall');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify error message is not displayed
    expect(find.text('Please enter the book title'), findsNothing);
  });

  testWidgets('Author form field validation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BookUploadPage()));

    // Enter invalid author
    await tester.enterText(find.byKey(Key('author')), '');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify error message is displayed
    expect(find.text('Please enter the book author'), findsOneWidget);

    // Enter valid author
    await tester.enterText(find.byKey(Key('author')), 'Jason');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify error message is not displayed
    expect(find.text('Please enter the book author'), findsNothing);
  });

  testWidgets('ISBN form field validation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BookUploadPage()));

    // Enter invalid ISBN
    await tester.enterText(find.byKey(Key('ISBN')), '');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify error message is displayed
    expect(find.text('Please enter the book ISBN'), findsOneWidget);

    // Enter valid ISBN
    await tester.enterText(find.byKey(Key('ISBN')), '1234567890');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify error message is not displayed
    expect(find.text('Please enter the book ISBN'), findsNothing);
  });

  testWidgets('Category form field', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BookUploadPage()));

    // Select category
    await tester.tap(find.byType(DropdownButtonFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fiction').last);
    await tester.pumpAndSettle();

    // Verify category is selected
    expect(find.text('Fiction'), findsOneWidget);
  });

  testWidgets('Front image picker', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BookUploadPage()));

    // Tap front image picker
    await tester.tap(find.text('Pick Front Image'));
    await tester.pumpAndSettle();

    // Verify image picker is displayed
    expect(find.byType(ImagePicker), findsOneWidget);
  });

  testWidgets('Back image picker', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BookUploadPage()));

    // Tap back image picker
    await tester.tap(find.text('Pick Back Image'));
    await tester.pumpAndSettle();

    // Verify image picker is displayed
    expect(find.byType(ImagePicker), findsOneWidget);
  });
}
