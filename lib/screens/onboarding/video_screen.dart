import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microsoft_teams_clone/constants.dart';
import 'package:microsoft_teams_clone/screens/onboarding/welcome_screen.dart';
import '../../widgets/rounded_button.dart';
import 'share_screen.dart';

class VideoScreen extends StatelessWidget {
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
    return VideoBody();
  }
}

class VideoBody extends StatelessWidget {
  const VideoBody({
    Key key,
  }) : super(key: key);

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
            "Connect with your loved ones via conference calls",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/onboarding_video.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
            buttonColor: appPrimaryColor,
            textColor: Colors.white,
            buttonText: "Next",
            onPress: () {
              // Navigates to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShareScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(height: 10),
          RoundedButton(
            buttonColor: appAccentColor,
            textColor: Colors.black,
            buttonText: "Previous",
            onPress: () {
              // Navigates to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WelcomeScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
