import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import '../../services/authentication/authentication.dart';
import 'user_info_page.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: appPurpleColor,
                shape: StadiumBorder(),
                padding: EdgeInsets.all(16),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserInfoPage(
                        user: user,
                      ),
                    ),
                  );
                }
              },
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
              label: Text(
                'Sign in with Google',
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
