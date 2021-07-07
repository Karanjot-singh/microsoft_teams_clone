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
    final client = StreamConfig.kDefaultStreamClient;
    final connectionStatus = client.wsConnectionStatus;
    // final connectionStatus = client.wsConnectionStatus;
    final navigator = MyApp.navigatorKey.currentState;

    switch (connectionStatus) {
      case ConnectionStatus.connected:
        if (_isSignedIn) return;
        log("karan: ConnectionStatus.connected");

        _isSignedIn = true;
        // navigator!.pushNamedAndRemoveUntil(
        //   Routes.HOME,
        //   ModalRoute.withName(Routes.HOME),
        //   arguments: HomePageArgs(client),
        // );
        break;
      case ConnectionStatus.disconnected:
        final isSignedInFirebase = FirebaseAuth.instance.currentUser != null;
        if (isSignedInFirebase) {
          log("karan: Sign in Firebase");
          return;
        }

        _isSignedIn = false;
        log("karan: Sign in Failed");

        // navigator.pushNamedAndRemoveUntil(
        //   Routes.SIGN_IN,
        //   ModalRoute.withName(Routes.SIGN_IN),
        // );
        break;
      default:
        break;
    }
  }

  Future login() async {
    try {
      log("before fAwait ");

      final isNewUser = await FirebaseGoogleApi.login();
      final userFirebase = FirebaseAuth.instance.currentUser;
      log("after fAwait ");

      if (isNewUser) {
        log("before Await new");

        await StreamUserApi.createUser(
          idUser: userFirebase!.uid,
          username: userFirebase.displayName!,
          urlImage: userFirebase.photoURL,
        );
        log("New user created $userFirebase.uid");
      } else {
        log("before Await exist");

        await StreamUserApi.login(idUser: userFirebase!.uid);
        log("login user created $userFirebase.uid");
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  void logout() async => StreamUserApi.logout();
}
