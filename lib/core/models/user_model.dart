import 'package:flutter/foundation.dart';

import 'model.dart';

class UserModel implements Model {
  final String id;
  final String email;
  final String nickName;
  final String imageUrl;
  final DateTime createdAt;

  UserModel({
    this.id,
    @required this.email,
    @required this.nickName,
    @required this.imageUrl,
    @required this.createdAt,
  });

  factory UserModel.fromMap(Map json, String id) {
    return UserModel(
      id: id ?? '',
      email: json['email'] ?? '',
      nickName: json['nickName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : null,
    );
  }

  toJson() {
    return {
      'email': email,
      'nickName': nickName,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
