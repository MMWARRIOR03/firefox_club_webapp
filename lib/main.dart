import 'package:firefox_club_webapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firefox_club_webapp/screens/event_list.dart';
import 'package:firefox_club_webapp/screens/login.dart';
import 'package:firefox_club_webapp/screens/dashboard.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Registration',
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.orange),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => LoginScreen(),
        '/events': (context) => EventListScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/home': (context) => homePage(),
      },
    );
  }
}
