import 'package:chat_ui_stream_iii_example/model/story.dart';
import 'package:flutter/cupertino.dart';

class UserStory {
  final List<Story> stories;
  final String userName;
  final String userImageUrl;

  const UserStory({
    required this.stories,
    required this.userName,
    required this.userImageUrl,
  });

  UserStory copy({
    List<Story> stories,
    String userName,
    String userImageUrl,
  }) =>
      UserStory(
        stories: stories ?? this.stories,
        userName: userName ?? this.userName,
        userImageUrl: userImageUrl ?? this.userImageUrl,
      );

  static UserStory fromJson(Map<String, dynamic> json) => UserStory(
        stories: json['stories'],
        userName: json['userName'],
        userImageUrl: json['userImageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'stories': stories,
        'userName': userName,
        'userImageUrl': userImageUrl,
      };
}
