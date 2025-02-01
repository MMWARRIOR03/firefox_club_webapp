import 'package:flutter/material.dart';
import 'package:firefox_club_webapp/services/google_sign_in_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'event_list.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  // Google Sign-In Service
  final GoogleSignInService _googleSignInService = GoogleSignInService();

  // Method to handle Google Sign-In
  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // Try signing in
    User? user = await _googleSignInService.signInWithGoogle();

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    // Check if the sign-in was successful
    if (user != null) {
      // Navigate to the next screen after successful login (e.g., Event Details)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EventListScreen()), // Adjust as per your screen
      );
    } else {
      // Show an error message if the email is invalid or sign-in failed
      _showErrorDialog();
    }
  }

  // Method to show error dialog
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Error"),
        content: Text("Only @vitbhopal.ac.in emails are allowed."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with Google"),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show loading indicator while signing in
            : ElevatedButton(
                onPressed: _signInWithGoogle,
                child: Text("Sign in with Google"),
              ),
      ),
    );
  }
}
