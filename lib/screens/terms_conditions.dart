// ignore_for_file: library_private_types_in_public_api

import 'package:booksgrid/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isChecked = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadAgreement();
  }

  Future<void> _loadAgreement() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = prefs.getBool('agreement') ?? false;
      _isButtonEnabled = _isChecked;
    });
  }

  Future<void> _saveAgreement(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('agreement', value);
    setState(() {
      _isChecked = value;
      _isButtonEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Text(
                "Welcome to Alibrary's terms and conditions&",
                style: GoogleFonts.arizonia(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'By using this app, you agree to the following terms and conditions:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '1. You will use the app only for lawful purposes and in accordance with these terms and conditions.\n\n2. You will not use the app in any way that may damage or impair the app, the server or the network connected to the app.\n\n3. You will not use the app to impersonate any person or entity or to falsely represent your affiliation with any person or entity.\n\n4. You will not engage in any unauthorized use or copying of any content or intellectual property of this app.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    _saveAgreement(value ?? false);
                  },
                ),
                Text(
                  'Agree to the Terms?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => (const SignUpScreen()))));
                    }
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
