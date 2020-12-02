import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String email;
  final String nickName;
  final String imageUrl;
  final Timestamp createdAt;

  const UserModel({
    @required this.id,
    @required this.email,
    @required this.nickName,
    @required this.imageUrl,
    @required this.createdAt,
  });


  UserModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        email = snapshot['email'] ?? '',
        nickName = snapshot['nickName'] ?? '',
        imageUrl = snapshot['imageUrl'] ?? '',
        createdAt = snapshot['createdAt'] ?? Timestamp.now();

  toJson() {
    return {
      'email': email,
      'nickName': nickName,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
