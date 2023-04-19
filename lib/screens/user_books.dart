// ignore_for_file: prefer_const_constructors, unused_field
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
# Import Dependencies
class UserBooksCollection extends StatefulWidget {
  const UserBooksCollection({Key? key}) : super(key: key);

  @override
  State<UserBooksCollection> createState() => _UserBooksCollectionState();
}

class _UserBooksCollectionState extends State<UserBooksCollection> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final List<String> _listItem = [];
  String? username;
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      username = loggedInUser.userName!;
      setState(() {});
    });
    fetchUserBookImages(username);
   
  }

  Future<List<String>> fetchUserBookImages(username) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('books')
        .where('uploadedBy', isEqualTo: username)
        .get();


    for (var doc in querySnapshot.docs) {
      if (doc.data().containsKey('frontImageUrl')) {
        String imageUrl = doc.data()['frontImageUrl'];
        _listItem.add(imageUrl);
      }
    }

    return _listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Books Collection"),
      ),
      body: _listItem.isNotEmpty ? Scrollbar(
        controller: _scrollController,
        child: GridView.count(
          controller: _scrollController,
          crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
          padding: EdgeInsets.all(16.0),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: _listItem.map((imageUrl) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(
                image: NetworkImage(imageUrl),
                width: 150,
                height: 200,
              ),
            );
          }).toList(),
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
