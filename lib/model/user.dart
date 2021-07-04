import 'package:meta/meta.dart';

class User {
  final String idUser;
  final String name;
  final String imageUrl;
  final bool isOnline;

  const User({
    required this.idUser,
    required this.name,
    required this.imageUrl,
    this.isOnline = false,
  });

  User copy({
    required String idUser,
    required String name,
    required String imageUrl,
    required bool isOnline,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        isOnline: isOnline ?? this.isOnline,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['idUser'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        isOnline: json['isOnline'],
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'imageUrl': imageUrl,
        'isOnline': isOnline,
      };

  int get hashCode => idUser.hashCode ^ name.hashCode ^ imageUrl.hashCode;

  bool operator ==(other) =>
      other is User &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      other.idUser == idUser;
}
