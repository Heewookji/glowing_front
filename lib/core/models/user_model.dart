import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String email;
  final String nickName;
  final String imageUrl;
  final Timestamp createdAt;

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
      createdAt: json['createdAt'] ??
          Timestamp.fromDate(
            DateTime(9999),
          ),
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
