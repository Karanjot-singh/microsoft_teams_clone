import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/services/stream_chat/stream_api.dart';
import 'package:microsoft_teams_clone/services/stream_chat/app_config.dart';
import 'package:microsoft_teams_clone/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../../routes/routes.dart';

//TODO Fix API String codes
const kStreamApiKey = 'STREAM_API_KEY';
const kStreamUserId = 'STREAM_USER_ID';
const kStreamToken = 'STREAM_TOKEN';

class ChooseUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = defaultUsers;
    // final users = {};

    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 34,
                bottom: 20,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 40,
                  color: appPurpleColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 13.0),
              child: Text(
                'Welcome to Stream Chat',
                style: StreamChatTheme.of(context).textTheme.title,
              ),
            ),
            Text(
              'Select a user to try the Flutter SDK:',
              style: StreamChatTheme.of(context).textTheme.body,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ListView.separated(
                  separatorBuilder: (context, i) {
                    return Container(
                      height: 1,
                      color: StreamChatTheme.of(context).colorTheme.greyWhisper,
                    );
                  },
                  itemCount: users.length + 1,
                  itemBuilder: (context, i) {
                    return [
                      ...users.entries.map((entry) {
                        //TODO:LOGIC reads the values from list of stored users
                        // generates a listtile for each entry
                        final token = entry.key;
                        final user = entry.value;
                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          onTap: () async {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              barrierColor: StreamChatTheme.of(context)
                                  .colorTheme
                                  .overlay,
                              builder: (context) => Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: StreamChatTheme.of(context)
                                        .colorTheme
                                        .white,
                                  ),
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: appAccentColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                            //TODO:LOGIC
                            final client = StreamChatClient(
                              kDefaultStreamApiKey,
                              logLevel: Level.INFO,
                            )..chatPersistenceClient =
                                StreamApi.chatPersistentClient;

                            //TODO:LOGIC
                            await client.connectUser(
                                // user,
                                User(
                                  id: 'salvatore',
                                  extraData: {
                                    'name': 'Salvatore Giordano',
                                    'image':
                                        'https://avatars.githubusercontent.com/u/20601437?s=460&u=3f66c22a7483980624804054ae7f357cf102c784&v=4',
                                  },
                                ),
                                // token,
                                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2FsdmF0b3JlIn0.pgiJz7sIc7iP29BHKFwe3nLm5-OaR_1l2P-SlgiC9a8'
                                //string
                                );
                            //TODO:LOGIC Serialisation of UserID
                            // to save the user state on second visit

                            final secureStorage = FlutterSecureStorage();
                            secureStorage.write(
                              key: kStreamApiKey,
                              value: kDefaultStreamApiKey,
                            );
                            secureStorage.write(
                              key: kStreamUserId,
                              value: 'salvatore',
                              // user.id,
                            );
                            secureStorage.write(
                              key: kStreamToken,
                              value:
                                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2FsdmF0b3JlIn0.pgiJz7sIc7iP29BHKFwe3nLm5-OaR_1l2P-SlgiC9a8',
                              // token,
                            );
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.HOME,
                              ModalRoute.withName(Routes.HOME),
                              arguments: HomePageArgs(client),
                            );
                          },
                          leading: UserAvatar(
                            user: user,
                            constraints: BoxConstraints.tight(
                              Size.fromRadius(20),
                            ),
                          ),
                          title: Text(
                            user.name,
                            style:
                                StreamChatTheme.of(context).textTheme.bodyBold,
                          ),
                          trailing: StreamSvgIcon.arrowRight(
                            color: appAccentColor,
                          ),
                        );
                      }),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.ADVANCED_OPTIONS);
                        },
                        leading: CircleAvatar(
                          child: StreamSvgIcon.settings(
                            color: StreamChatTheme.of(context).colorTheme.black,
                          ),
                          backgroundColor: StreamChatTheme.of(context)
                              .colorTheme
                              .greyWhisper,
                        ),
                        title: Text(
                          'Advanced Options',
                          style: StreamChatTheme.of(context).textTheme.bodyBold,
                        ),
                        subtitle: Text(
                          'Custom settings',
                          style: StreamChatTheme.of(context)
                              .textTheme
                              .footnote
                              .copyWith(
                                color: appLightColor,
                              ),
                        ),
                      ),
                    ][i];
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
