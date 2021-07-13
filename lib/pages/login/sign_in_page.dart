import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/config/custom_colors.dart';
import 'google_sign_in_button.dart';

import '../../services/authentication/authentication.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size makes the app responsive to various screen sizes

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            // Positioned(
            //   top: 0,
            //   left: -20,
            //   child: Image.asset(
            //     "assets/images/signup_top.png",
            //     width: size.width * 0.3,
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/android_icon.png",
                  width: size.width * 0.15,
                ),
                SizedBox(height: size.height * 0.02),

                Text(
                  "Microsoft Teams",
                  style: TextStyle(
                      color: appPurpleColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.02),
                // new Image.asset('android_icon.png', width: 100.0, height: 100.0),
                // SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Login to this Experience",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/mobile.svg",
                  height: size.height * 0.35,
                  alignment: Alignment.center,
                ),
                SizedBox(height: size.height * 0.03),
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColors.firebaseOrange,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
