// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, body_might_complete_normally_nullable, unused_element, use_build_context_synchronously,, unused_import, unused_field, depend_on_referenced_packages, deprecated_member_use, prefer_const_literals_to_create_immutables, unnecessary_this

import 'package:booksgrid/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:booksgrid/model/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

import '../model/user_model.dart';

class BookUploadPage extends StatefulWidget {
  const BookUploadPage({Key? key}) : super(key: key);

  @override
  _BookUploadPageState createState() => _BookUploadPageState();
}

class _BookUploadPageState extends State<BookUploadPage> {
  final _book = FirebaseFirestore.instance;
  late User? user;
  late UserModel loggedInUser;
  final _descriptionScrollController = ScrollController();
// Get the user document from Firestore using the user's UID
  final Color _buttonColor = Colors.grey;
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  String? _selectedCategory;

  File? _frontImageFile;
  File? _backImageFile;
  late String _frontImageUrl;
  late String _backImageUrl;
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _uploadedByController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      _uploadedByController.text = loggedInUser.userName!;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _authorController.dispose();
    _titleController.dispose();
    _isbnController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _uploadedByController.dispose();
    super.dispose();
  }

  Future<void> _pickFrontImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _frontImageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _pickBackImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _backImageFile = File(pickedFile.path);
      }
    });
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('book_images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _uploadImages() async {
    try {
      final frontImageRef = FirebaseStorage.instance.ref(
          'book_images/${DateTime.now().millisecondsSinceEpoch}_front.jpg');
      final frontTask = frontImageRef.putFile(_frontImageFile!);
      final backImageRef = FirebaseStorage.instance
          .ref('book_images/${DateTime.now().millisecondsSinceEpoch}_back.jpg');
      final backTask = backImageRef.putFile(_backImageFile!);
      final frontSnapshot = await frontTask.whenComplete(() {});
      final backSnapshot = await backTask.whenComplete(() {});
      _frontImageUrl = await frontSnapshot.ref.getDownloadURL();
      _backImageUrl = await backSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Failed to upload images: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Book'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the book title';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: _authorController,
                  decoration: InputDecoration(
                    labelText: 'Author',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the book author';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: _isbnController,
                  decoration: InputDecoration(
                    labelText: 'ISBN',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the book ISBN';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                  ),
                  value: _selectedCategory,
                  items: <String>[
                    'Fiction',
                    'Non-fiction',
                    'Children',
                    'Young Adult',
                    'Business',
                    'Thriller',
                    'Comedy',
                    'Motivation',
                    'Social Issues'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a book category';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 50.0,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _descriptionScrollController,
                    child: SingleChildScrollView(
                      controller: _descriptionScrollController,
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: null, // Allow user to enter multiple lines
                        decoration: InputDecoration(
                          labelText: 'Book Description',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().split(' ').length > 100) {
                            return 'Please enter a brief description of the book (maximum 100 words)';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: _uploadedByController,
                  decoration: InputDecoration(
                    labelText: 'Uploaded By',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _pickFrontImage,
                            child: Text('Choose Front Image'),
                          ),
                          ElevatedButton(
                            onPressed: _pickBackImage,
                            child: Text('Choose Back Image'),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 8.0),
                        Flexible(
                          child: Text(_frontImageFile != null
                              ? path.basename(_frontImageFile!.path)
                              : 'No front image selected'),
                        ),
                        SizedBox(width: 16.0),
                        Flexible(
                          child: Text(_backImageFile != null
                              ? path.basename(_backImageFile!.path)
                              : 'No back image selected'),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ],
                ),

                // SizedBox(height: 16.0),
                SizedBox(
                  width: 200.0,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final frontImageUrl =
                                  await _uploadImageToStorage(_frontImageFile!);
                              final backImageUrl =
                                  await _uploadImageToStorage(_backImageFile!);

                              BookModel newBook = BookModel(
                                author: _authorController.text,
                                title: _titleController.text,
                                isbn: _isbnController.text,
                                category: _selectedCategory,
                                description: _descriptionController.text,
                                frontImageUrl: frontImageUrl,
                                backImageUrl: backImageUrl,
                                uploadedBy: _uploadedByController.text,
                              );

                              Map<String, dynamic> data = newBook.toMap();

                              await FirebaseFirestore.instance
                                  .collection('books')
                                  .add(data);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${newBook.title} novel uploaded successfully!'),
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);

                              _authorController.clear();
                              _titleController.clear();
                              _isbnController.clear();
                              _categoryController.clear();
                              _descriptionController.clear();
                              setState(() {
                                _frontImageFile = null;
                                _backImageFile = null;
                              });
                            } on FirebaseException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to upload book: $e'),
                                ),
                              );
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload),
                            SizedBox(width: 8.0),
                            Text('Upload'),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
