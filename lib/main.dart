// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, unnecessary_this, sdk_version_constructor_tearoffs, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison, avoid_print, unused_field

import 'dart:io';

import 'package:booksgrid/screens/book_details.dart';
import 'package:booksgrid/screens/notifications.dart';
import 'package:booksgrid/screens/profile.dart';
import 'package:booksgrid/screens/sign_in.dart';
import 'package:booksgrid/screens/sign_up.dart';
import 'package:booksgrid/screens/settings.dart';
import 'package:booksgrid/screens/upload_book.dart';
import 'package:booksgrid/screens/upload_profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'model/user_model.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';

// Initialize firebase
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // For messaging purposes
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  late String _ProfileImageUrl;

  @override
  void initState() {
    super.initState();
    requestPermission();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(
        () {},
      );
    });
    fetchBookImages();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

  final List<String> _listItem = [];
  final List<String> _isbnList = [];
  final List<String> _profList = [];

  Future<void> fetchBookImages() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        querySnapshot.docs;
    for (final doc in docs) {
      final frontImageUrl = doc.get('frontImageUrl');
      final isbn = doc.get('isbn');
      try {
        setState(() {
          _listItem.add(frontImageUrl);
          _isbnList.add(isbn);
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error loading image: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text("Alibrary"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.manage_search_rounded),
            ),
          )
        ],
      ),
      // Drawer code
      drawer: SizedBox(
        width: 280,
        child: Drawer(
          elevation: 16,
          child: Align(
            alignment: AlignmentDirectional(-0.1, 0),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  width: 100,
                  height: 217.9,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: AlignmentDirectional(-0.1, -0.2),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(75, 30, 0, 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // enable change of profile picture

                              Container(
                                width: 129,
                                height: 129,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              child: Image.network(loggedInUser.profilePicture?.isNotEmpty == true
                                  ? '${loggedInUser.profilePicture}'
                                    : 'https://picsum.photos/seed/716/600',
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(width: 10),

                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => uploadProfile()),
                                  );
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.15, -0.25),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                          child: Text(
                            '${loggedInUser.userName}\n${loggedInUser.email}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1, 0.15),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => (HomePage()))));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.home_sharp,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Home',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => (Profile()))));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.location_history,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                    )),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => (NotificationsPage()))));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications_active,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Notifications',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                    )),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => (SettingsPage()))));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF303030),
                        size: 20,
                      ),
                      tileColor: Colors.white,
                      dense: false,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: ListTile(
                    leading: Icon(
                      Icons.plumbing,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Plugins',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: Colors.white,
                    dense: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: InkWell(
                    onTap: () async {
                      Logout(context);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      tileColor: Colors.white,
                      dense: false,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/book3.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Top Rated Book",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                            child: Text(
                          "View",
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Gridview to display the collection of book images in the Application\
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _listItem
                      .map(
                        (item) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => (BookDetailsPage(
                                      isbn: _isbnList[_listItem.indexOf(item)],
                                    ))),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.blue,
                            elevation: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: item != null
                                    ? DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: Transform.translate(
                                offset: Offset(50, -50),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 65, vertical: 63),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Icon(Icons.bookmark_border, size: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (BookUploadPage())));
        },
        child: Icon(Icons.upload_file),
      ),
    );
  }

  // Log out function
  Future<void> Logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
