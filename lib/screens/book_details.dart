// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BookDetailsPage extends StatefulWidget {
  final String isbn;

  const BookDetailsPage({Key? key, required this.isbn}) : super(key: key);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late Future<QuerySnapshot<Map<String, dynamic>>> _bookFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = FirebaseFirestore.instance
        .collection('books')
        .where('isbn', isEqualTo: widget.isbn)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _bookFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final book = snapshot.data!.docs.first.data();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(book['frontImageUrl']),
                SizedBox(height: 16),
                Text(
                  book['title'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'By ${book['author']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  book['description'],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching book details'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}