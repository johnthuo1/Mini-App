// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class BookDetailsPage extends StatelessWidget {
//   const BookDetailsPage({
//     Key? key,
//     required this.bookImage,
//     required this.bookTitle,
//     required this.bookDescription,
//     required this.bookRating,
//     required this.onBorrowPressed,
//   }) : super(key: key);

//   final String bookImage;
//   final String bookTitle;
//   final String bookDescription;
//   final double bookRating;
//   final VoidCallback onBorrowPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(
//               height: 200,
//               child: Image.network(
//                 bookImage,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     bookTitle,
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     bookDescription,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.yellow),
//                       SizedBox(width: 8),
//                       Text(bookRating.toStringAsFixed(1)),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: onBorrowPressed,
//                     child: Text('Book'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
