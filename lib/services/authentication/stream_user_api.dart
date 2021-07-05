import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microsoft_teams_clone/pages/users/choose_user_page.dart';
// import 'package:foundation/model/user_token.dart';
// import 'package:foundation/request/authentication_request.dart';
// import 'package:foundation/request/authentication_response.dart';
import 'package:microsoft_teams_clone/services/stream_chat/app_config.dart';
import 'package:microsoft_teams_clone/services/stream_chat/stream_api.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
// import 'package:microsoft_teams_clone/model/user.dart' as model;
// import 'package:http/http.dart' as http;

import 'firebase_google_api.dart';

class StreamUserApi {
  static Future createUser({
    required String idUser,
    required String username,
    required String urlImage,
  }) async {
    // final userToken = await _generateUserToken(idUser: idUser);
    final userToken = StreamConfig.kDefaultStreamClient.devToken(idUser);

    final client = StreamChatClient(
      kDefaultStreamApiKey,
      logLevel: Level.INFO,
    )..chatPersistenceClient = StreamApi.chatPersistentClient;

    final user = User(
      id: idUser,
      extraData: {
        'name': username,
        'image': urlImage,
      },
    );
    await StreamConfig.kDefaultStreamClient.connectUser(user, userToken.token);
    final secureStorage = FlutterSecureStorage();
    secureStorage.write(
      key: kStreamApiKey,
      value: kDefaultStreamApiKey,
    );
    secureStorage.write(
      key: kStreamUserId,
      value: user.id,
    );
    secureStorage.write(
      key: kStreamToken,
      value: userToken.token,
    );
    log("New user created $user.id");
  }

  static Future login({required String idUser}) async {
    final userToken = StreamConfig.kDefaultStreamClient.devToken(idUser);

    // final userToken = await _generateUserToken(idUser: idUser);

    final user = User(id: idUser);
    await StreamConfig.kDefaultStreamClient.connectUser(user, userToken.token);
    final secureStorage = FlutterSecureStorage();
    secureStorage.write(
      key: kStreamApiKey,
      value: kDefaultStreamApiKey,
    );
    secureStorage.write(
      key: kStreamUserId,
      value: user.id,
    );
    secureStorage.write(
      key: kStreamToken,
      value: userToken.token,
    );
    log("Login user created $user.id");
  }

  // static Future<UserToken> _generateUserToken({
  //   required String idUser,
  // }) async {
  //   const urlAuthentication =
  //       'https://us-central1-stream-chat-test-c4556.cloudfunctions.net/createToken';
  //   final headers = <String, String>{
  //     'Content-Type': 'application/json',
  //   };

  //   final request = AuthenticationRequest(idUser: idUser);
  //   final json = jsonEncode(request.toJson());

  //   final response =
  //       await http.post(urlAuthentication, headers: headers, body: json);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final reviewResponse = AuthenticationResponse.fromJson(data);

  //     if (reviewResponse.error.isNotEmpty) {
  //       throw UnimplementedError(
  //           'Error: generateToken ${reviewResponse.error}');
  //     } else {
  //       return reviewResponse.userToken;
  //     }
  //   } else {
  //     throw UnimplementedError('Error: generateToken');
  //   }
  // }

  static Future logout() async {
    await FirebaseGoogleApi.logout();
    await FirebaseAuth.instance.signOut();
    await StreamConfig.kDefaultStreamClient.disconnect(
      clearUser: true,
      flushOfflineStorage: true,
    );
  }
}
