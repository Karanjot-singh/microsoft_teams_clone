import 'package:chat_ui_stream_iii_example/utils/utils.dart';
import 'package:flutter/foundation.dart';

class Story {
  final String imageUrl;
  final DateTime time;

  const Story({
    required this.imageUrl,
    required this.time,
  });

  Story copy({
    String imageUrl,
    DateTime time,
  }) =>
      Story(
        imageUrl: imageUrl ?? this.imageUrl,
        time: time ?? this.time,
      );

  static Story fromJson(Map<String, dynamic> json) => Story(
        imageUrl: json['imageUrl'],
        time: Utils.toDateTime(json['time']),
      );

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'time': Utils.fromDateTimeToJson(time),
      };
}
