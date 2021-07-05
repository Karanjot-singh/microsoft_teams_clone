import 'dart:developer';

import 'package:microsoft_teams_clone/main.dart';
import 'package:microsoft_teams_clone/pages/home/home_page.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:microsoft_teams_clone/services/authentication/firebase_google_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/services/authentication/stream_user_api.dart';
import 'package:microsoft_teams_clone/services/stream_chat/app_config.dart';
import 'package:microsoft_teams_clone/services/stream_chat/stream_api.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GoogleSignInProvider extends ChangeNotifier {
  bool _isSignedIn = false;

  GoogleSignInProvider() {
    _listenStatus();
  }

  Future _listenStatus() async {
    final client = StreamChatClient(
      kDefaultStreamApiKey,
      logLevel: Level.INFO,
    )..chatPersistenceClient = StreamApi.chatPersistentClient;
    // final connectionStatus = client.wsConnectionStatus;
    final navigator = MyApp.navigatorKey.currentState;

    navigator!.pushNamedAndRemoveUntil(
      Routes.HOME,
      ModalRoute.withName(Routes.HOME),
      arguments: HomePageArgs(client),
    );

    // client.wsConnectionStatus.addListener(
    //   () {
    //     final status = connectionStatus.value;

    //     switch (status) {
    //       case ConnectionStatus.connected:
    //         if (_isSignedIn) return;

    //         _isSignedIn = true;
    //         navigator!.pushNamedAndRemoveUntil(
    //           Routes.HOME,
    //           ModalRoute.withName(Routes.HOME),
    //           arguments: HomePageArgs(client),
    //         );
    //         break;
    //       case ConnectionStatus.disconnected:
    //         final isSignedInFirebase =
    //             FirebaseAuth.instance.currentUser != null;
    //         if (isSignedInFirebase) {
    //           log("karan: Sign in Failed");
    //           return;
    //         }

    //         _isSignedIn = false;
    //         navigator!.pushNamedAndRemoveUntil(
    //           Routes.SIGN_IN,
    //           ModalRoute.withName(Routes.SIGN_IN),
    //         );
    //         break;
    //       default:
    //         break;
    //     }
    //   },
    // );
  }

  Future login() async {
    try {
      final isNewUser = await FirebaseGoogleApi.login();
      final userFirebase = FirebaseAuth.instance.currentUser;

      if (isNewUser) {
        log("before Await new");

        await StreamUserApi.createUser(
          idUser: userFirebase!.uid,
          username: userFirebase.displayName!,
          urlImage: userFirebase.photoURL!,
        );
        log("New user created $userFirebase.uid");
      } else {
        log("before Await exist");

        await StreamUserApi.login(idUser: userFirebase!.uid);
        log("login user created $userFirebase.uid");
      }
    } catch (e) {}

    notifyListeners();
  }

  void logout() async => StreamUserApi.logout();
}
