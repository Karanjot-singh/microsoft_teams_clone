import 'package:microsoft_teams_clone/pages/chats/chats_home_page.dart';
import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/pages/login/sign_in_page.dart';
import 'package:microsoft_teams_clone/pages/meetings/create_meetings_page.dart';
import 'package:microsoft_teams_clone/pages/meetings/join_meetings_page.dart';
import 'package:microsoft_teams_clone/pages/meetings/meetings_page.dart';
import 'package:microsoft_teams_clone/pages/onboarding/share_screen.dart';
import 'package:microsoft_teams_clone/pages/onboarding/video_screen.dart';
import 'package:microsoft_teams_clone/pages/onboarding/welcome_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../pages/chats/group_chat/channel_page.dart';
import '../pages/chats/chat_info_page.dart';
import '../pages/chats/group_chat/channel_name_page.dart';
import '../pages/chats/group_chat/channel_info_page.dart';
import '../home_page.dart';
import '../main.dart';
import '../pages/chats/new_chat/new_chat_page.dart';
import '../pages/chats/new_chat/add_channel_members_page.dart';
import 'routes.dart';

/*
This Constructs a MaterialPageRoute for each of the pages created in the application
in an organised manner for scalable projects
*/
class AppRoutes {
  /// Add entry for new route here
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.APP:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.APP),
            builder: (_) {
              return MyApp();
            });
      case Routes.HOME:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.HOME),
            builder: (_) {
              final homePageArgs = args as HomePageArgs;
              return HomePage(
                chatClient: homePageArgs.chatClient,
              );
            });
      case Routes.SIGN_IN:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHOOSE_USER),
            builder: (_) {
              return SignInPage();
            });
      case Routes.MEET:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHOOSE_USER),
            builder: (_) {
              return MeetingsPage();
            });
      case Routes.JOIN_MEET:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHOOSE_USER),
            builder: (_) {
              return JoinMeetingsPage();
            });
      case Routes.CREATE_MEET:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHOOSE_USER),
            builder: (_) {
              return CreateMeetingsPage();
            });
      case Routes.CHANNEL_PAGE:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHANNEL_PAGE),
            builder: (_) {
              final channelPageArgs = args as ChannelPageArgs;
              return StreamChannel(
                channel: channelPageArgs.channel!,
                initialMessageId: channelPageArgs.initialMessage?.id,
                child: ChannelPage(
                  highlightInitialMessage:
                      channelPageArgs.initialMessage != null,
                ),
              );
            });
      case Routes.NEW_CHAT:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_CHAT),
            builder: (_) {
              return NewChatPage();
            });
      case Routes.ONBOARD1:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_CHAT),
            builder: (_) {
              return WelcomeScreen();
            });
      case Routes.ONBOARD2:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_CHAT),
            builder: (_) {
              return VideoScreen();
            });
      case Routes.ONBOARD3:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_CHAT),
            builder: (_) {
              return ShareScreen();
            });
      case Routes.NEW_CHANNEL:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_CHANNEL),
            builder: (_) {
              return AddChannelMembersPage();
            });
      case Routes.NEW_CHANNEL_DETAILS:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_CHANNEL_DETAILS),
            builder: (_) {
              return ChannelNamePage(
                selectedUsers: args as List<User>?,
              );
            });
      case Routes.CHAT_INFO_SCREEN:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHAT_INFO_SCREEN),
            builder: (context) {
              return ChatInfoPage(
                user: args as User?,
                messageTheme: StreamChatTheme.of(context).ownMessageTheme,
              );
            });
      case Routes.GROUP_INFO_SCREEN:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.GROUP_INFO_SCREEN),
            builder: (context) {
              return ChannelInfoPage(
                messageTheme: StreamChatTheme.of(context).ownMessageTheme,
              );
            });
      case Routes.CHANNEL_LIST_PAGE:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHANNEL_LIST_PAGE),
            builder: (context) {
              return ChatsHomePage();
            });

      // Default case, should not reach here.
      default:
        return null;
    }
  }
}

Route routeToSignInPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignInPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
