import 'package:microsoft_teams_clone/provider/google_signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Facebook Messenger'),
        ),
        body: Center(child: buildSignIn(context)),
      );

  Widget buildSignIn(BuildContext context) => OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          shape: StadiumBorder(),
          padding: EdgeInsets.all(20),
        ),
        label: Text(
          'Sign In With Google',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.login();
        },
      );
}
