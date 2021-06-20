import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/constants.dart';
import 'package:microsoft_teams_clone/screens/onboarding/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Microsoft Teams Clone',
      theme: ThemeData(
        // This is the theme of your application.
        primaryColor: appPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
