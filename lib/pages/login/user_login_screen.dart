import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import '../../widgets/rounded_button.dart';

class UserLoginScreen extends StatelessWidget {
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
    return LoginBody();
  }
}

class LoginBody extends StatelessWidget {
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
            "Almost there...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: appPurpleColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.40,
          ),
          TextFieldContainer(
            child: TextField(),
          ),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
            buttonColor: appPurpleColor,
            buttonText: "Login",
            onPress: () {},
          ),
          SizedBox(height: 10),
          RoundedButton(
            buttonColor: appAccentColor,
            textColor: Colors.black,
            buttonText: "Sign Up",
            onPress: () {},
          ),
        ],
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: appLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      width: size.width * 0.8,
    );
  }
}
