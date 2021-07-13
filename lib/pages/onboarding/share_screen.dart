import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/pages/login/sign_in_page.dart';
import 'package:microsoft_teams_clone/pages/onboarding/welcome_screen.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:page_transition/page_transition.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size makes the app responsive to various screen sizes
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Share Multiple Files, Images & GIFs",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: appPurpleColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/onboarding_share.svg",
              height: size.height * 0.40,
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              height: size.height * 0.055,
              width: size.width * 0.5,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: VideoScreen(),
                    ),
                  );
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: appPurpleColor,
                    shape: StadiumBorder()),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              height: size.height * 0.055,
              width: size.width * 0.5,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: WelcomeScreen(),
                    ),
                  );
                },
                child: Text(
                  "Previous",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: appPurpleColor,
                    shape: StadiumBorder()),
              ),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
