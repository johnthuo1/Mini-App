// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api

import 'package:booksgrid/screens/sign_in.dart';
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
  bool _allowStorageAccess = true;
  bool _allowDataAccess = true;
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
          ListTile(
            title: Text('Privacy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Privacy page
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
          SwitchListTile(
            title: Text('Allow Storage Access'),
            value: _allowStorageAccess,
            onChanged: (value) {
              setState(() {
                _allowStorageAccess = value;
              });
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Access Data'),
            value: _allowDataAccess,
            onChanged: (value) {
              setState(() {
                _allowDataAccess = value;
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
