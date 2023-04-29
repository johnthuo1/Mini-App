// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booksgrid/screens/book_details.dart';

void main() {
  testWidgets('Test error message when book is not found', (WidgetTester tester) async {
    // Mock a query snapshot with an empty docs list

    // Build the book details page widget with the mocked snapshot
    await tester.pumpWidget(MaterialApp(home: BookDetailsPage(isbn: '345678e56',)));

    // Tap the borrow button to trigger the _onBorrowButtonPressed function
    await tester.tap(find.byType(ElevatedButton));

    // Rebuild the widget tree with the error message
    await tester.pumpAndSettle();

    // Check if the error message is displayed
    expect(find.text('Book not found'), findsOneWidget);
  });
}
