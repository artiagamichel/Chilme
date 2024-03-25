import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'loginform.dart';




import 'package:flutter/material.dart';
// Update the import statement to point to the correct location of LoginPage

class Signupform extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Signupform({super.key});
// Implement the sign-up logic in the Signupform class
  void _signUp(BuildContext context) async {
    try {
      if (_isValidEmail(_emailController.text)) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Navigate to the dashboard after successful sign-up
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        if (kDebugMode) {
          print('Error signing up: Invalid email format');
        }
        // Handle invalid email format error
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing up: $e');
      }
      // Handle other sign-up errors
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Widget _loginForm(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Do you have an account? ',
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginForm()),
            );
          },
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up Form',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: const Icon(Icons.person),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _signUp(context);
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            _loginForm(context),
          ],
        ),
      ),
    );
  }
}
