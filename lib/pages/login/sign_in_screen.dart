import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/config/custom_colors.dart';
import 'package:microsoft_teams_clone/pages/login/user_login_screen.dart';
import 'package:microsoft_teams_clone/widgets/rounded_button.dart';
import 'google_sign_in_button.dart';

import '../../services/authentication/authentication.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size makes the app responsive to various screen sizes
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 30.0,
            top: 30.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Almost there...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: appLightColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.40,
              ),
              SizedBox(height: size.height * 0.03),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
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
        ),
      ),
    );
  }
}
