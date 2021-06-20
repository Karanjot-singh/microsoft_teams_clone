import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size makes the app responsive to various screen sizes
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome to Microsoft Teams!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "App developed by Karanjot Singh",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SvgPicture.asset("assets/")
      ],
    );
  }
}
