// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_field, unnecessary_null_comparison, unnecessary_new, library_private_types_in_public_api, depend_on_referenced_packages, unused_local_variable, use_build_context_synchronously

import 'package:booksgrid/main.dart';
import 'package:booksgrid/screens/notifications.dart';
import 'package:booksgrid/screens/settings.dart';
import 'package:booksgrid/screens/sign_in.dart';
import 'package:booksgrid/screens/sign_up.dart';
import 'package:booksgrid/screens/user_books.dart';
import 'package:booksgrid/screens/user_information.dart';
// import 'package:booksgrid/screens/user_books.dart';
// import 'package:booksgrid/screens/user_information.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:booksgrid/model/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  // final double _drawerIconSize = 24;
  // final double _drawerFontSize = 17;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final List<String> _listItem = [];
  String? username;

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
      setState(
        () {},
      );
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
        title: Padding(
          padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: Text(
            "Profile Page",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ])),
        ),
        //Dont show that annoying back_arrow
        // automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: GestureDetector(
              onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> (NotificationsPage())));
              },
              child: Stack(
                children: <Widget>[
                  Icon(Icons.notifications),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
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
                              Container(
                                width: 129,
                                height: 129,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/716/600',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              // InkWell(
                              //   child: SizedBox(
                              //     width: 50,
                              //     height: 50,
                              //     child: Icon(
                              //       Icons.camera_alt,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              // child: HeaderWidget(100,false,Icons.house_rounded),),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${loggedInUser.userName}\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8.0, bottom: 4.0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "User Information",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserInformationPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Email"),
                                          subtitle:
                                              Text('${loggedInUser.email}'),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.password),
                                          title: Text("Unique Id"),
                                          subtitle: Text("***********"),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8.0, bottom: 4.0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "My Books",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              // View All Button
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserBooksCollection()),
                                  );
                                },
                                child: Text('View All'),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                // Limit the number of book images to show to 5 book images.
                                // _listItem.take(5).map((item))
                                // A user has to click on 'View All' to see all the book images he/she uploaded to the application.
                                children: _listItem.map((item) {
                                  return Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image(
                                            image: NetworkImage(item),
                                            width: 150,
                                            height: 200,
                                          )),
                                      // Spacing between book images
                                      SizedBox(width: 10),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Log out functionality
  // ignore: non_constant_identifier_names
  Future<void> Logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
