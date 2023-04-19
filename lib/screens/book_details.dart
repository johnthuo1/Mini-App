// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_field, use_build_context_synchronously
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
  bool _bookBorrowed = false;

  @override
  void initState() {
    super.initState();
    _bookFuture = FirebaseFirestore.instance
        .collection('books')
        .where('isbn', isEqualTo: widget.isbn)
        .get();
  }

  void _onBorrowButtonPressed() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('isbn', isEqualTo: widget.isbn)
        .get();

    final book = snapshot.docs.first;
    if (book['borrowed'] == true) {
      // Show an error message that the book is already borrowed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This book is already borrowed.')),
      );
      return;
    }

    // Update the 'borrowed' field to true
    book.reference.update({'borrowed': true});

    // Set the borrowed flag to true and update the UI
    setState(() {
      _bookBorrowed = true;
    });

    // Show a confirmation message that the book has been borrowed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You have borrowed this book.')),
    );
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
                // Add animations on the Book Image to make it look better
                Padding(
                  padding: EdgeInsets.fromLTRB(90, 20, 0, 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        book['frontImageUrl'] ?? '',
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image_not_supported);
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
                Text(
                  book['title'] ?? 'Title not provided for this book',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'By ${book['author'] ?? 'Author not provided for this book'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  book['description'] ??
                      'Description not provided for this book',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),

                // Add the Borrow Book button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: _bookBorrowed ? null : _onBorrowButtonPressed,
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _bookBorrowed ? Colors.grey : Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _bookBorrowed ? 'Book Borrowed' : 'Borrow Book',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Encountered Error while fetching book details'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
