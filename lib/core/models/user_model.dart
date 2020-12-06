import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserMessageRoomModel {
  final String roomId;
  final List<String> users;

  UserMessageRoomModel({
    this.roomId,
    @required this.users,
  });

  factory UserMessageRoomModel.fromMap(Map json, String roomId) {
    List<dynamic> users = json['users'];
    return UserMessageRoomModel(
      roomId: roomId ?? '',
      users: users == null
          ? List()
          : users.map((user) => user.toString()).toList(),
    );
  }

  toJson() {
    return {
      'users': users,
    };
  }
}

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

  UserModel.fromMap(Map json, String id)
      : id = id ?? '',
        email = json['email'] ?? '',
        nickName = json['nickName'] ?? '',
        imageUrl = json['imageUrl'] ?? '',
        createdAt = json['createdAt'] ?? Timestamp.fromDate(DateTime(9999));

  toJson() {
    return {
      'email': email,
      'nickName': nickName,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
