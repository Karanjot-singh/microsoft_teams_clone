import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/*
Option Tile Widgets for info screen of channels and private chats.
Generalised and Modular Tiles implemented
*/


// ignore: must_be_immutable
class MuteOptionTile extends StatelessWidget {
  MuteOptionTile({
    Key? key,
    required this.trailingWidget,
    required this.text,
  }) : super(key: key);

  Widget trailingWidget;
  String text;

  @override
  Widget build(BuildContext context) {
    return OptionListTile(
      tileColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      separatorColor: StreamChatTheme.of(context).colorTheme.greyGainsboro,
      title: 'Mute group',
      titleTextStyle: StreamChatTheme.of(context).textTheme.body,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: StreamSvgIcon.mute(
          size: 24.0,
          color: appAccentIconColor,
        ),
      ),
      trailing: trailingWidget,
      onTap: () {},
    );
  }
}
