// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Book {
  final String name;
  final String author;
  final String isbn;

  Book({this.name, this.author, this.isbn,});
}

class BookTable extends StatefulWidget {
  const BookTable({Key key}) : super(key: key);

  @override
  _BookTableState createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  List<Book> books = [
    Book(
        name: 'Weep Not, Child',
        author: 'Ngugi Wa Thiongo',
        isbn: '9780446310789',

),
    Book(
        name: 'Great Expectations',
        author: 'Charles Dickens',
        isbn: '9780451524935',

),
    Book(
        name: 'Purple Hibiscus',
        author: 'Chimamanda Ngozi Adichie',
        isbn: '9780743273565',

),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Table'),
      ),
      body: SingleChildScrollView(

        scrollDirection: Axis.horizontal,

        child: DataTable(
          columns: [
            DataColumn(label: Text('Book')),
            DataColumn(label: Text('Author')),
            DataColumn(label: Text('ISBN')),
          ],
          rows: books.map((book) {
            return DataRow(cells: [
              DataCell(Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text(book.name),
                ],
              )
              ,
              onTap: () {
                  // handle edit book author
                },),
              DataCell(Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text(book.author),
                ],
              ),
              onTap: () {
                  // handle edit book author
                },
              ),
    
              DataCell(Text(book.isbn)),

            ]);
          }).toList(),
        ),
      ),
    );
  }
}
