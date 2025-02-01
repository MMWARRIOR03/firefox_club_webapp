import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign-in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In process
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently();
      if (googleUser == null) {
        // The user canceled the login process
        return null;
      }

      // Get the authentication details from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase Authentication
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Get the signed-in user
      final User? user = userCredential.user;

      // Check if the email ends with "@vitbhopal.ac.in"
      if (user != null &&
          user.email != null &&
          user.email!.endsWith('@vitbhopal.ac.in')) {
        return user; // Successfully signed in and email is valid
      } else {
        // Sign out if the email is not valid
        await _auth.signOut();
        return null;
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  getProfileImage() {
    if (FirebaseAuth.instance.currentUser?.photoURL != null) {
      return FirebaseAuth.instance.currentUser!.photoURL!;
    } else {
      return Icon(
        Icons.account_circle,
        size: 100,
        color: Colors.white,
      );
    }
  }

  getUserName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final name = user.displayName;
      // Check if user's email is verified
      final emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      final uid = user.uid;
      return name;
    }
  }

  getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      // Check if user's email is verified
      final emailVerified = user.emailVerified;

      return email;
    }
  }
}
