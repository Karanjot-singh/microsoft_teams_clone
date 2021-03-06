import 'dart:async';
import 'package:microsoft_teams_clone/services/stream_chat/stream_api.dart';
import 'package:microsoft_teams_clone/pages/login/user_info_page.dart';
import 'package:microsoft_teams_clone/home_page.dart';
import 'package:microsoft_teams_clone/pages/onboarding/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with SplashScreenStateMixin, TickerProviderStateMixin {
  // mixins implemented for multiple inheritance like functionality
  InitData? _initData; //Nullable type indicated by ?
  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<InitData> _initConnection() async {
    String? apiKey, userId, token;
    final secureStorage = FlutterSecureStorage();
    /*FLutter Secure Storage is used to retain user details and preferences
    in order to keep them saved on each new launch*/
    apiKey = await secureStorage.read(key: kStreamApiKey);
    userId = await secureStorage.read(key: kStreamUserId);
    token = await secureStorage.read(key: kStreamToken);

    final client = StreamChatClient(
      apiKey ?? StreamApi.kDefaultStreamApiKey,
      // ?? null-aware operator which returns the expression on its left
      // unless that expression’s value is null
      logLevel: Level.INFO,
    )..chatPersistenceClient = StreamApi.chatPersistentClient;
    // shorthand setter for chatPersistentClient

    StreamApi.setClient(client);
    if (userId != null && token != null) {
      await client.connectUser(
        // Sets the current user and connect the websocket using the userID and token generated
        /// a user token using our server SDK
        User(id: userId),
        token,
      );
    }

    final prefs = await StreamingSharedPreferences.instance;
    //Wraps Shared Preferences with a Stream-based layer,
    //allowing you to listen to changes in the underlying values.

    return InitData(client, prefs);
  }

  @override
  void initState() {
    // Sets the splash screen & animation delay
    final timeOfStartMs = DateTime.now().millisecondsSinceEpoch;

    _initConnection().then(
      (initData) {
        setState(() {
          _initData = initData;
        });
        //sets the _init as a callback after the connection is established
        // with the API

        final now = DateTime.now().millisecondsSinceEpoch;

        if (now - timeOfStartMs > 1500) {
          SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
            forwardAnimations();
          });
        } else {
          Future.delayed(Duration(milliseconds: 1500)).then((value) {
            forwardAnimations();
          });
        }
      },
      //
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_initData != null)
          PreferenceBuilder<int>(
            preference: _initData!.preferences.getInt(
              'theme',
              defaultValue: 0,
            ),
            builder: (context, snapshot) => MaterialApp(
              navigatorKey: navigatorKey,
              // Initialising the theme of the application
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: {
                -1: ThemeMode.dark,
                0: ThemeMode.system,
                1: ThemeMode.light,
              }[snapshot],
              builder: (context, child) => StreamChatTheme(
                data: StreamChatThemeData(
                  brightness: Theme.of(context).brightness,
                ),
                child: child!,
              ),
              onGenerateRoute: AppRoutes.generateRoute,
              onGenerateInitialRoutes: (initialRouteName) {
                if (initialRouteName == Routes.HOME) {
                  return [
                    AppRoutes.generateRoute(
                      RouteSettings(
                        name: Routes.HOME,
                        arguments: HomePageArgs(_initData!.client),
                      ),
                    )!
                  ];
                }
                return [
                  AppRoutes.generateRoute(
                    RouteSettings(
                      // name: Routes.SIGN_IN,
                      name: Routes.ONBOARD1,
                    ),
                  )!
                ];
              },
              initialRoute: _initData!.client.state.user == null
                  //Choose the launch screen on basis of the state of user login
                  // ? Routes.SIGN_IN
                  ? Routes.ONBOARD1
                  : Routes.HOME,
            ),
          ),
        if (!animationCompleted) buildAnimation(),
      ],
    );
  }
}
