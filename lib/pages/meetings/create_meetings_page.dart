import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateMeetingsPage extends StatefulWidget {
  const CreateMeetingsPage({Key? key}) : super(key: key);

  @override
  _CreateMeetingsPageState createState() => _CreateMeetingsPageState();
}

class _CreateMeetingsPageState extends State<CreateMeetingsPage> {
  String code = "";
  createCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  joinMeet() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      var options = JitsiMeetingOptions(room: code)
        ..userDisplayName = "Karan"
        ..audioMuted = false
        ..videoMuted = true
        ..featureFlags.addAll(featureFlags);

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Create Meeting',
          style: TextStyle(
              color: StreamChatTheme.of(context).colorTheme.black,
              fontSize: 16.0),
        ),
        leading: StreamBackButton(),
        backgroundColor: appPurpleColor,
      ),
      backgroundColor: StreamChatTheme.of(context).colorTheme.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(),
          SizedBox(
            height: 40,
          ),
          Container(
            width: size.width * 0.4,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: appPurpleColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Code:",
                  style: TextStyle(
                    color: StreamChatTheme.of(context).colorTheme.black,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  code,
                  style: TextStyle(
                      color: appLightColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.05),

          SizedBox(
            height: 25,
          ),

          SvgPicture.asset(
            "assets/icons/two-meet.svg",
            height: size.height * 0.35,
          ),

          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => createCode(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: appAccentIconColor,
              ),
              width: MediaQuery.of(context).size.width * 0.4,
              height: 50,
              child: Center(
                child: Text(
                  "Create Code",
                  style: TextStyle(
                    color: StreamChatTheme.of(context).colorTheme.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => joinMeet(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: appAccentIconColor,
              ),
              width: MediaQuery.of(context).size.width * 0.4,
              height: 50,
              child: Center(
                child: Text(
                  "Join Meeting",
                  style: TextStyle(
                    color: StreamChatTheme.of(context).colorTheme.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          // Add Join Meeting
        ],
      ),
    );
  }
}
