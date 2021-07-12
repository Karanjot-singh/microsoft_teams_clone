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

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
    required this.chatClient,
  }) : super(key: key);

  final StreamChatClient chatClient;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StreamChat(
      client: widget.chatClient,
      streamChatThemeData: StreamChatThemeData(
        brightness: Theme.of(context).brightness,
        channelListHeaderTheme: ChannelListHeaderTheme(
          color: appPurpleColor,
        ),
        colorTheme: Theme.of(context).brightness == Brightness.dark
            ? ColorTheme.dark(
                accentBlue: appPurpleColor,
              )
            : ColorTheme.light(
                accentBlue: appPurpleColor,
              ),
        channelTheme: ChannelTheme(
          channelHeaderTheme: ChannelHeaderTheme(
            color: appPurpleColor,
            subtitle: TextStyle(
              color: appLightColor,
            ),
          ),
        ),
        messageInputTheme: MessageInputTheme(
          actionButtonColor: appPurpleColor,
          actionButtonIdleColor: appPurpleColor,
          sendButtonIdleColor: appPurpleColor,
          sendButtonColor: appPurpleColor,
        ),
        otherMessageTheme: MessageTheme(
          messageBackgroundColor: StreamChatTheme.of(context)
              .colorTheme
              .accentGreen
              .withOpacity(0.5),
          messageBorderColor: StreamChatTheme.of(context)
              .colorTheme
              .accentGreen
              .withOpacity(0.5),
        ),
        ownMessageTheme: MessageTheme(
          messageBackgroundColor: appPurpleColor.withOpacity(0.5),
          messageBorderColor: appPurpleColor,
        ),
        primaryIconTheme: IconThemeData(color: appPurpleColor),
      ),
      child: WillPopScope(
        onWillPop: () async {
          final canPop = await _navigatorKey.currentState?.maybePop() ?? false;
          return !canPop;
        },
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: Routes.CHANNEL_LIST_PAGE,
        ),
      ),
    );
  }
}
