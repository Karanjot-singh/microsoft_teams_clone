import 'package:chat_ui_stream_iii_example/api/firebase_google_api.dart';
import 'package:chat_ui_stream_iii_example/api/stream_api.dart';
import 'package:chat_ui_stream_iii_example/api/stream_user_api.dart';
import 'package:chat_ui_stream_iii_example/app_routes.dart';
import 'package:chat_ui_stream_iii_example/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/routes/app_routes.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GoogleSignInProvider extends ChangeNotifier {
  bool _isSignedIn = false;

  GoogleSignInProvider() {
    _listenStatus();
  }

  Future _listenStatus() async {
    final connectionStatus = StreamApi.client.wsConnectionStatus;

    connectionStatus.addListener(() {
      final navigator = MyApp.navigatorKey.currentState;
      final status = connectionStatus.value;

      switch (status) {
        case ConnectionStatus.connected:
          if (_isSignedIn) return;

          _isSignedIn = true;
          navigator.pushNamedAndRemoveUntil(
            AppRoutes.home,
            ModalRoute.withName('/'),
          );
          break;
        case ConnectionStatus.disconnected:
          final isSignedInFirebase = FirebaseAuth.instance.currentUser != null;
          if (isSignedInFirebase) return;

          _isSignedIn = false;
          navigator.pushNamedAndRemoveUntil(
            AppRoutes.auth,
            ModalRoute.withName('/'),
          );
          break;
        default:
          break;
      }
    });
  }

  Future login() async {
    try {
      final isNewUser = await FirebaseGoogleApi.login();
      final userFirebase = FirebaseAuth.instance.currentUser;

      if (isNewUser) {
        await StreamUserApi.createUser(
          idUser: userFirebase.uid,
          username: userFirebase.displayName,
          urlImage: userFirebase.photoURL,
        );
      } else {
        await StreamUserApi.login(idUser: userFirebase.uid);
      }
    } catch (e) {}

    notifyListeners();
  }

  void logout() async => StreamUserApi.logout();
}
