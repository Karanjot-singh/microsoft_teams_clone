import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/pages/onboarding/video_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../widgets/rounded_button.dart';

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
    return SafeArea(
      minimum: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Microsoft Teams!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: appPurpleColor,
            ),
            textAlign: TextAlign.center,
          ),
          // SizedBox(height: size.height * 0.03),
          // Text(
          //   "App developed by Karanjot Singh",
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
          SizedBox(height: size.height * 0.03),
          // SvgPicture.asset(
          //   "assets/icons/onboarding_chat.svg",
          //   height: size.height * 0.40,
          // ),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
            buttonColor: appPurpleColor,
            buttonText: "Next",
            onPress: () {
              // Navigates to the next screen
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: VideoScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
