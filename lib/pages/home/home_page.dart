import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/routes/app_routes.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomePageArgs {
  final StreamChatClient chatClient;

  HomePageArgs(this.chatClient);
}

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.chatClient,
  }) : super(key: key);

  final StreamChatClient chatClient;

  @override
  Widget build(BuildContext context) {
    return StreamChat(
      client: chatClient,
      streamChatThemeData: StreamChatThemeData(
        channelListHeaderTheme: ChannelListHeaderTheme(
          color: appPurpleColor,
        ),
        // colorTheme: ColorTheme.dark(
        //   accentBlue: appPurpleColor,
        // ),
        channelTheme: ChannelTheme(
          channelHeaderTheme: ChannelHeaderTheme(
            color: appPurpleColor,
            subtitle: TextStyle(
              color: appLightColor,
            ),
          ),
        ),
        messageInputTheme: MessageInputTheme(
          actionButtonColor: appAccentColor,
          sendButtonColor: appAccentColor,
        ),
        otherMessageTheme: MessageTheme(
          reactionsMaskColor: appAccentColor,
          messageBackgroundColor: StreamChatTheme.of(context)
              .colorTheme
              .accentBlue
              .withOpacity(0.5),
          messageBorderColor: StreamChatTheme.of(context)
              .colorTheme
              .accentBlue
              .withOpacity(0.5),
        ),
        ownMessageTheme: MessageTheme(
          messageBackgroundColor: appPurpleColor.withOpacity(0.5),
          messageBorderColor: appPurpleColor,
        ),
        primaryIconTheme: IconThemeData(color: appAccentColor),
        brightness: Theme.of(context).brightness,
      ),
      child: Navigator(
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: Routes.CHANNEL_LIST_PAGE,
      ),
    );
  }
}
