// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, body_might_complete_normally_nullable, unused_element, use_build_context_synchronously,, unused_import, unused_field, depend_on_referenced_packages, deprecated_member_use, prefer_const_literals_to_create_immutables, unnecessary_this, unnecessary_import

import 'package:booksgrid/main.dart';
import 'package:booksgrid/screens/profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:booksgrid/model/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

import '../model/user_model.dart';

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  late User? user;
  late UserModel loggedInUser;
// Get the user document from Firestore using the user's UID
  final Color _buttonColor = Colors.grey;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();

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
      _usernameController.text = loggedInUser.userName!;
      _emailController.text = loggedInUser.email!;
      _uidController.text = loggedInUser.uid!;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _uidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Username
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),

                // Email Address
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                ),
                // User Unique Id. A user can't edit it.
                SizedBox(height: 16.0),
                GestureDetector(
                  child: TextFormField(
                    controller: _uidController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Unique Id',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Do not edit';
                      }
                      return null;
                    },
                  ),
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Editing Disabled for Unique Id Field'),
                    ));
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => (Profile())));
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Delete Account'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: 200.0,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              UserModel user = UserModel(
                                userName: _usernameController.text,
                                email: _emailController.text,
                                uid: _uidController.text,
                              );

                              Map<String, dynamic> userData = user.toMap();

                              // Update user data in 'users' collection
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(loggedInUser.uid)
                                  .update(userData);

                              // To ensure that the new username matches the 'uploadedBy' in books collection,
                              // Update 'uploadedBy' field in the 'books' collection
                              QuerySnapshot querySnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('books')
                                      .where('uploadedBy',
                                          isEqualTo: loggedInUser.userName)
                                      .get();

                              WriteBatch batch =
                                  FirebaseFirestore.instance.batch();
                              for (var doc in querySnapshot.docs) {
                                DocumentReference docRef = FirebaseFirestore
                                    .instance
                                    .collection('books')
                                    .doc(doc.id);
                                batch.update(docRef,
                                    {'uploadedBy': _usernameController.text});
                              }

                              await batch.commit();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Your profile has been updated successfully!'),
                                ),
                              );

                              // Update logged in user object with new data
                              loggedInUser.userName = _usernameController.text;
                              loggedInUser.email = _emailController.text;
                              loggedInUser.uid = _uidController.text;

                              _usernameController.clear();
                              _emailController.clear();
                              _uidController.clear();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()),
                              );
                            } on FirebaseException {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Failed to update user profile'),
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
                            Text('Update Profile'),
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
