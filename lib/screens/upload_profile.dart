// ignore_for_file: camel_case_types, prefer_const_constructors, library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:booksgrid/main.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class uploadProfile extends StatefulWidget {
  const uploadProfile({Key? key}) : super(key: key);

  @override
  _uploadProfileState createState() => _uploadProfileState();
}

class _uploadProfileState extends State<uploadProfile> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> updateUserProfilePicture(String downloadUrl) async {
    // Get the currently logged in user
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Update the user's profile picture in the 'users' collection
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'profilePicture': downloadUrl,
      });
    }
  }

  Future uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(_image!);
    await uploadTask.whenComplete(() => print('Image uploaded to Firebase storage'));

    // Get the download URL of the uploaded image
    String downloadUrl = await storageReference.getDownloadURL();

    // Update the user's profile picture in the database
    await updateUserProfilePicture(downloadUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: getImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.camera_alt, size: 50) : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _image != null
                  ? () async {
                      await uploadImage();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile Picture uploaded successfully!')),
                      );

                     Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                    }
                  : null,
              child: Text('Upload'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Choose Image'),
            ),
          ],
        ),
      ),
    );
  }
}
