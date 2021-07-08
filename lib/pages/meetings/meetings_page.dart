import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class MeetingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Connect with Friends & Family",
                style: TextStyle(
                    color: StreamChatTheme.of(context).colorTheme.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            // SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      splashColor: appPurpleColor,
                      tooltip: "Create a Meeting",
                      iconSize: 50,
                      icon: FaIcon(FontAwesomeIcons.solidPlusSquare,
                          color: appPurpleColor),
                      onPressed: (){
                        Navigator.pushNamed(
                          context,
                          Routes.CREATE_MEET,
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "New Meeting",
                      style: TextStyle(
                        color: StreamChatTheme.of(context).colorTheme.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      splashColor: appPurpleColor,
                      tooltip: "Join a Meeting",
                      iconSize: 50,
                      icon:
                          FaIcon(FontAwesomeIcons.video, color: appPurpleColor),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.JOIN_MEET,
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Join Meeting",
                      style: TextStyle(
                        color: StreamChatTheme.of(context).colorTheme.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: 50),

            SvgPicture.asset(
              "assets/icons/conference.svg",
              height: size.height * 0.35,
              alignment: Alignment.center,
            ),
            // Add Join Meeting
          ],
        ),
      ),
    );
  }
}
