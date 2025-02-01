import 'package:animated_background/animated_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/google_sign_in_service.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> with TickerProviderStateMixin {
  // Example logged-in state
  bool isLoggedIn = false; // Set to true if the user is logged in
  String userProfileImage = GoogleSignInService().getProfileImage().toString();
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
      setState(() {
        isLoggedIn = true;
        userProfileImage =
            GoogleSignInService().getProfileImage().toString(); // User image
        print(userProfileImage);
      });
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

  void _showProfileMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(200, 60, 0, 0),
      items: [
        if (isLoggedIn) ...[
          PopupMenuItem(
            value: 1,
            child: Text('Profile'),
            onTap: () {
              // Handle Profile action
              print("Profile clicked");
            },
          ),
          PopupMenuItem(
            value: 2,
            child: Text('Settings'),
            onTap: () {
              // Handle Settings action
              print("Settings clicked");
            },
          ),
          PopupMenuItem(
            value: 3,
            child: Text('Logout'),
            onTap: () {
              // Handle Logout action
              setState(() {
                GoogleSignInService().signOut();
                isLoggedIn = false;
                userProfileImage = 'assets/images/fox.png';
              });
            },
          ),
        ],
        if (!isLoggedIn) ...[
          PopupMenuItem(
            value: 4,
            child: Text('Sign In'),
            onTap: _signInWithGoogle,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.white12,
                backgroundImage: isLoggedIn
                    ? NetworkImage(userProfileImage)
                    : AssetImage('assets/images/fox.png'),
              ),
              onPressed: () {
                _showProfileMenu(context);
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            baseColor: Colors.orange,
            spawnMaxSpeed: 100.0,
            spawnMinSpeed: 50.0,
            spawnMaxRadius: 4.0,
            spawnMinRadius: 3.0,
            particleCount: 200,
            spawnOpacity: 0,
            minOpacity: 0.1,
            maxOpacity: 0.7,
            opacityChangeRate: 1,
          ),
        ),
        vsync: this,
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'MOZILLA FIREFOX CLUB',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Times',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'A student club in VIT Bhopal University',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Times',
                      ),
                    ),
                    const SizedBox(height: 80),
                    Container(
                      child: Text(
                        'Mozilla Firefox Club-VIT is the club for Mozilla Firefox open-source community enthusiasts at VIT University, Bhopal.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Times',
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    const Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Times',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Mozilla Firefox Club VIT, one of the largest developers' communities in VIT, Vellore has been working with an aspiration of changing ideas into reality ever since its inception. With a 6 year rich history as one of the top technical clubs comprising a team of over 150+ core members, 3 mentors, and 10 as the executive board, dedicated to technically strengthening the students by integrating their skills in various fields of Engineering & Technology, so as to face the highly competitive environment. We provide a morale boosting system for the talented youth through our professional endeavors and inspire each student at VIT and beyond to follow our academic interests and goals. We have a diverse audience from over 15 countries as a part of the students we teach. Creating value through real world impact-driven projects.",
                      style: TextStyle(
                        decorationStyle: TextDecorationStyle.wavy,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Text('Login to view events',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(context, '/events');
                      },
                      label: const Text('View Events'),
                      icon: const Icon(Icons.event),
                      backgroundColor: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
