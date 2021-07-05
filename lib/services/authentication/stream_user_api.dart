import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';
// import 'package:foundation/model/user_token.dart';
// import 'package:foundation/request/authentication_request.dart';
// import 'package:foundation/request/authentication_response.dart';
import 'package:microsoft_teams_clone/services/stream_chat/app_config.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:microsoft_teams_clone/model/user.dart' as model;
import 'package:http/http.dart' as http;

import 'firebase_google_api.dart';

class StreamUserApi {
  static Future<List<model.User>> getAllUsers({bool includeMe = false}) async {
    final sort = SortOption('last_message_at');
    final response =
        await StreamConfig.kDefaultStreamClient.queryUsers(sort: [sort]);

    final defaultImage =
        'https://images.unsplash.com/photo-1580907114587-148483e7bd5f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    final allUsers = response.users
        .map((user) => model.User(
              idUser: user.id,
              name: user.name,
              imageUrl: user.extraData['image'] ?? defaultImage,
              isOnline: user.online,
            ))
        .toList();

    return allUsers;
  }

  static Future createUser({
    required String idUser,
    required String username,
    required String urlImage,
  }) async {
    // final userToken = await _generateUserToken(idUser: idUser);
    final userToken = StreamConfig.kDefaultStreamClient.devToken(idUser);

    final user = User(
      id: idUser,
      extraData: {
        'name': username,
        'image': urlImage,
      },
    );
    await StreamConfig.kDefaultStreamClient.setUser(user, userToken.token);
  }

  static Future login({required String idUser}) async {
    final userToken = StreamConfig.kDefaultStreamClient.devToken(idUser);

    // final userToken = await _generateUserToken(idUser: idUser);

    final user = User(id: idUser);
    await StreamConfig.kDefaultStreamClient.setUser(user, userToken.token);
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
