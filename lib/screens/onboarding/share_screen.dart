import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microsoft_teams_clone/constants.dart';
import '../../widgets/rounded_button.dart';
import 'video_screen.dart';

class ShareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShareBody();
  }
}

class ShareBody extends StatelessWidget {
  const ShareBody({
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
            "Share Multiple Files, Images & GIFs",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: appPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/onboarding_share.svg",
            height: size.height * 0.40,
          ),
          SizedBox(height: size.height * 0.01),
          RoundedButton(
            buttonColor: appPrimaryColor,
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
                    return VideoScreen();
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
