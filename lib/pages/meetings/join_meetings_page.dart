import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/widgets/drawer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:microsoft_teams_clone/config/constants.dart';

class JoinMeetingsPage extends StatefulWidget {
  const JoinMeetingsPage({Key? key}) : super(key: key);

  @override
  _JoinMeetingsPageState createState() => _JoinMeetingsPageState();
}

class _JoinMeetingsPageState extends State<JoinMeetingsPage> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _codecontroller = TextEditingController();

  bool _isAudioDisabled = true;
  bool _isVideoDisabled = true;
  bool _isAnonymous = true;

  String code = "";

  joinMeet() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      var _finalName = _namecontroller.text;
      if (_namecontroller.text.isEmpty) {
        _finalName = LeftDrawer.userName!;
      }
      var options = JitsiMeetingOptions(room: _codecontroller.text)
        ..userDisplayName = _isAnonymous ? "Anonymous User" : _finalName
        ..audioMuted = _isAudioDisabled
        ..videoMuted = _isVideoDisabled
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
      resizeToAvoidBottomInset: false, //To awoid Bottom Overflow
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Join Meeting',
          style: TextStyle(
              color: StreamChatTheme.of(context).colorTheme.black,
              fontSize: 16.0),
        ),
        leading: StreamBackButton(),
        backgroundColor: appPurpleColor,
      ),
      backgroundColor: StreamChatTheme.of(context).colorTheme.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Meeting Code",
                style: TextStyle(
                    color: StreamChatTheme.of(context).colorTheme.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            PinCodeTextField(
              length: 6,
              autoDisposeControllers: false,
              pinTheme: PinTheme(
                activeColor: appPurpleColor,
                activeFillColor: appPurpleColor,
                disabledColor: appLightColor,
                inactiveColor: appLightColor,
                selectedColor: appPurpleColor,
                shape: PinCodeFieldShape.underline,
              ),
              animationType: AnimationType.fade,
              animationDuration: Duration(milliseconds: 300),
              onChanged: (value) {},
              appContext: context,
              controller: _codecontroller,
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              controller: _namecontroller,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: StreamChatTheme.of(context).colorTheme.grey,
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 2),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mic Disabled",
                      style: TextStyle(
                        color: StreamChatTheme.of(context).colorTheme.black,
                        fontSize: 14.0,
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: appAccentColor,
                      value: _isAudioDisabled,
                      onChanged: (val) {
                        setState(() {
                          _isAudioDisabled = val;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Video Disabled",
                      style: TextStyle(
                        color: StreamChatTheme.of(context).colorTheme.black,
                        fontSize: 14.0,
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: appAccentColor,
                      value: _isVideoDisabled,
                      onChanged: (val) {
                        setState(() {
                          _isVideoDisabled = val;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Anonymous Mode",
                      style: TextStyle(
                        color: StreamChatTheme.of(context).colorTheme.black,
                        fontSize: 14.0,
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: appAccentColor,
                      value: _isAnonymous,
                      onChanged: (val) {
                        setState(() {
                          _isAnonymous = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Divider(thickness: 2),

            SizedBox(height: 20),
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
            SizedBox(height: 40),

            SvgPicture.asset(
              "assets/icons/two-meet.svg",
              height: size.height * 0.25,
            ),

            SizedBox(
              height: 25,
            ),
            // Add Join Meeting
          ],
        ),
      ),
    );
  }
}
