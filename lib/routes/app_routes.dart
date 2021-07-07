import 'package:microsoft_teams_clone/pages/chats/chats_list_page.dart';
import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/pages/onboarding/auth_page.dart';
import 'package:microsoft_teams_clone/pages/onboarding/sign_in_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../pages/users/advanced_options_page.dart';
import '../pages/chats/group_chat/group_chats_page.dart';
import '../pages/chats/chat_info_screen.dart';
import '../pages/users/choose_user_page.dart';
import '../pages/chats/group_chat/group_chat_details_screen.dart';
import '../pages/chats/group_chat/group_info_screen.dart';
import '../pages/home/home_page.dart';
import '../main.dart';
import '../pages/chats/new_chat/new_chat_screen.dart';
import '../pages/chats/new_chat/new_group_chat_screen.dart';
import 'routes.dart';

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
      case Routes.CHOOSE_USER:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHOOSE_USER),
            builder: (_) {
              return ChooseUserPage();
            });
      case Routes.SIGN_IN:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHOOSE_USER),
            builder: (_) {
              return SignInScreen();
              // return AuthPage();
            });
      case Routes.ADVANCED_OPTIONS:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.ADVANCED_OPTIONS),
          builder: (_) => AdvancedOptionsPage(),
        );
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
              return NewChatScreen();
            });
      case Routes.NEW_GROUP_CHAT:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_GROUP_CHAT),
            builder: (_) {
              return NewGroupChatScreen();
            });
      case Routes.NEW_GROUP_CHAT_DETAILS:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.NEW_GROUP_CHAT_DETAILS),
            builder: (_) {
              return GroupChatDetailsScreen(
                selectedUsers: args as List<User>?,
              );
            });
      case Routes.CHAT_INFO_SCREEN:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHAT_INFO_SCREEN),
            builder: (context) {
              return ChatInfoScreen(
                user: args as User?,
                messageTheme: StreamChatTheme.of(context).ownMessageTheme,
              );
            });
      case Routes.GROUP_INFO_SCREEN:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.GROUP_INFO_SCREEN),
            builder: (context) {
              return GroupInfoScreen(
                messageTheme: StreamChatTheme.of(context).ownMessageTheme,
              );
            });
      case Routes.CHANNEL_LIST_PAGE:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.CHANNEL_LIST_PAGE),
            builder: (context) {
              return ChannelListPage();
            });
      // Default case, should not reach here.
      default:
        return null;
    }
  }
}
