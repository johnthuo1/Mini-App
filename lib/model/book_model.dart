// ignore_for_file: unused_import
// Book Model to use for db
import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String? title;
  String? author;
  String? isbn;
  String? category;
  String? frontImageUrl;
  String? backImageUrl;
  String? uploadedBy;

  BookModel(
      {this.title,
      this.author,
      this.isbn,
      this.category,
      this.frontImageUrl,
      this.backImageUrl,
      this.uploadedBy});

  // create a factory constructor from a DocumentSnapshot
  factory BookModel.fromMap(map) {
    return BookModel(
      title: map['title'],
      author: map['author'],
      isbn: map['isbn'],
      category: map['category'],
      frontImageUrl: map['frontImageUrl'],
      backImageUrl: map['backImageUrl'],
      uploadedBy: map['uploadedBy'],
    );
  }

  // converts to a Map for uploading to Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'isbn': isbn,
      'category': category,
      'frontImageUrl': frontImageUrl,
      'backImageUrl': backImageUrl,
      'uploadedBy': uploadedBy,
    };
  }
}
