// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api

import 'package:booksgrid/screens/forgot_password.dart';
import 'package:booksgrid/screens/sign_in.dart';
import 'package:booksgrid/screens/upload_profile.dart';
import 'package:booksgrid/screens/user_books.dart';
import 'package:flutter/material.dart';
import 'package:booksgrid/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _allowNotifications = true;
  bool _showAvatar = true;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Kinyarwanda', 'French'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
            ListTile(
            title: Text('Change Profile Picture'),
            trailing: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.account_box_rounded)),
            onTap: 
              () async {
                     // Change profile picture
                     Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => (uploadProfile())));
            },
  
          ),

          Divider(),
          ListTile(
            title: Text('Change Password'),
            trailing: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.key)),
            onTap: 
              () async {
                            // Take User to Forgot Password Page
                     Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
            },
  
          ),
          Divider(),

          ListTile(
            title: Text('My Books Collection'),
            trailing: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.library_books),
            ),
            onTap: () async {
              // Take User to Forgot Password Page
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserBooksCollection()));
            },
          ),

          Divider(),

          SwitchListTile(
            title: Text('Allow Notifications'),
            value: _allowNotifications,
            onChanged: (value) {
              setState(() {
                _allowNotifications = value;
              });
            },
          ),

          Divider(),
          SwitchListTile(
            title: Text('Display Mode'),
            value: _showAvatar,
            onChanged: (value) {
              setState(() {
                _showAvatar = value;
              });
            },
          ),
          Divider(),
          ListTile(
            title: Text('App Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Log Out'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              // Log out user
              Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
