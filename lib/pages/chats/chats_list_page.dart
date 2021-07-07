import 'dart:async';

import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/pages/meetings/join_meetings_page.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:microsoft_teams_clone/pages/mentions/user_mentions_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:microsoft_teams_clone/widgets/drawer.dart';

import 'chat_list.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChannelListPageState createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  int _currentIndex = 0;

  bool _isSelected(int index) => _currentIndex == index;

  List<BottomNavigationBarItem> get _navBarItems {
    return <BottomNavigationBarItem>[
      // Icon for Join meetings page
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            StreamSvgIcon.iconGroup(
              color: _isSelected(0) ? appAccentColor : Colors.grey,
            ),
          ],
        ),
        label: 'Meetings',
      ),
      // Icon for user chats page
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            StreamSvgIcon.message(
              color: _isSelected(1) ? appAccentColor : Colors.grey,
            ),
            Positioned(
              top: -3,
              right: -16,
              child: UnreadIndicator(),
            ),
          ],
        ),
        label: 'Chats',
      ),
      // Icon for user mentions page
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            StreamSvgIcon.mentions(
              color: _isSelected(2) ? appAccentColor : Colors.grey,
            ),
          ],
        ),
        label: 'Mentions',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).user;
    if (user == null) {
      return Offstage();
    }
    return Scaffold(
      //scaffold for search box
      backgroundColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      appBar: ChannelListHeader(
        titleBuilder: (context, connectionStatus, streamClient) {
          return Text(
            'Microsoft Teams',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: StreamChatTheme.of(context).colorTheme.black,
                fontSize: 16.0),
          );
        },
        onNewChatButtonTap: () {
          Navigator.pushNamed(context, Routes.NEW_CHAT);
        },
        preNavigationCallback: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
      drawer: LeftDrawer(
        user: user,
      ),
      drawerEdgeDragWidth: 50,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: StreamChatTheme.of(context).colorTheme.white,
        currentIndex: _currentIndex,
        items: _navBarItems,
        selectedLabelStyle: StreamChatTheme.of(context).textTheme.footnoteBold,
        unselectedLabelStyle:
            StreamChatTheme.of(context).textTheme.footnoteBold,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: StreamChatTheme.of(context).colorTheme.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      body: IndexedStack(
        // To map the indexes of Pages with Bottom Navigation Bar icons
        index: _currentIndex,
        children: [
          JoinMeetingsPage(),
          ChannelList(),
          UserMentionsPage(),
        ],
      ),
    );
  }

  StreamSubscription<int>? badgeListener;

  @override
  void initState() {
    badgeListener = StreamChat.of(context)
        .client
        .state
        .totalUnreadCountStream
        .listen((count) {
      if (count > 0) {
        FlutterAppBadger.updateBadgeCount(count);
      } else {
        FlutterAppBadger.removeBadge();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    badgeListener?.cancel();
    super.dispose();
  }
}
