import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapp/signupform.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _errors = TextEditingController();

  //functions
  void _Login() async {
    String email = _email.text.trim();
    String password = _password.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errors.text = 'Email and password are required';
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _errors.text = 'Invalid email format';
      });
      return;
    }
    if (password.length < 6) {
      if (kDebugMode) {
        print('Error signing up: Password should be at least 6 characters');
      }
      // Handle password length error
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errors.text = 'Firebase Auth Error: ${e.message}';
      });
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.message}');
      }
    } catch (e) {
      setState(() {
        _errors.text = 'Error: $e';
      });
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  bool _isValidEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(),
              _inputField(),
              _forgotPassword(),
              _loginButton(
                  context), // Pass the context to the _loginButton method
              _signup(context), // Pass the context to the _signup method
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  Widget _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _email, // Add this line
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _password, // Add this line
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _forgotPassword() {
    return TextButton(
      onPressed: () {
        // Add logic for forgot password functionality
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _Login(); // Call the _Login method when the button is pressed
        _validateAndLogin(); // Call the _validateAndSignIn method when the button is pressed
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color.fromARGB(255, 39, 176, 165),
      ),
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  void _validateAndLogin() {
    String email = _email.text.trim();
    String password = _password.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errors.text = 'Email and password are required';
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _errors.text = 'Invalid email format';
      });
      return;
    }

    _Login();
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Signupform(),
              ),
            );
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}
