import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: StreamChatTheme.of(context).colorTheme.white,
        child: SafeArea(
          // child: SizedBox(c)
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 8,
                ),
                child: Container(
                  color: appPurpleColor,
                  height: MediaQuery.of(context).viewPadding.top + 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      UserAvatar(
                        user: user,
                        showOnlineStatus: false,
                        constraints: BoxConstraints.tight(Size.fromRadius(20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: StreamSvgIcon.iconGroup(
                  color: appAccentColor.withOpacity(.8),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.NEW_CHAT,
                  );
                },
                title: Text(
                  'New Meeting',
                  style: TextStyle(
                    fontSize: 14.5,
                  ),
                ),
              ),
              ListTile(
                leading: StreamSvgIcon.penWrite(
                  color: appAccentColor.withOpacity(.8),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.NEW_CHAT,
                  );
                },
                title: Text(
                  'New direct message',
                  style: TextStyle(
                    fontSize: 14.5,
                  ),
                ),
              ),
              ListTile(
                leading: StreamSvgIcon.userAdd(
                  color: appAccentColor.withOpacity(.8),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.NEW_GROUP_CHAT,
                  );
                },
                title: Text(
                  'New group',
                  style: TextStyle(
                    fontSize: 14.5,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    onTap: () async {
                      Navigator.pop(context);

                      final secureStorage = FlutterSecureStorage();
                      await secureStorage.deleteAll();

                      final client = StreamChat.of(context).client;
                      client.disconnectUser();
                      await client.dispose();

                      await Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamedAndRemoveUntil(
                        Routes.CHOOSE_USER,
                        ModalRoute.withName(Routes.CHOOSE_USER),
                      );
                    },
                    leading: StreamSvgIcon.userRemove(
                      color: appAccentColor,
                    ),
                    title: Text(
                      'Sign out',
                      style: TextStyle(
                        fontSize: 14.5,
                      ),
                    ),
                    trailing: IconButton(
                      icon: StreamSvgIcon.iconMoon(
                        size: 24,
                      ),
                      color: StreamChatTheme.of(context).colorTheme.whiteSnow,
                      onPressed: () async {
                        final sp = await StreamingSharedPreferences.instance;
                        sp.setInt(
                          'theme',
                          Theme.of(context).brightness == Brightness.dark
                              ? 1
                              : -1,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}