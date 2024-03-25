import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              FontAwesomeIcons
                  // ignore: deprecated_member_use
                  .signOutAlt, // Use FontAwesomeIcons.signOutAlt for the sign-out icon
              size: 20.0, // Reduce the size of the icon if needed
              color: Color.fromARGB(255, 136, 54, 244),
            ),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Dashboard!',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Logged in as:',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              user != null ? user.email ?? '' : '',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
