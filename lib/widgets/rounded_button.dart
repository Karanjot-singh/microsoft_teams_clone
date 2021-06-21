import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onPress;
  final Color buttonColor, textColor;
  const RoundedButton({
    Key key,
    this.buttonText,
    this.onPress,
    this.buttonColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: TextButton(
        onPressed: onPress,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        style: TextButton.styleFrom(
            primary: textColor,
            backgroundColor: buttonColor,
            shape: StadiumBorder()),
      ),
    );
  }
}
