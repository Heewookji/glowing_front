import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserMessageRoomModel {
  final String roomId;
  final String name;
  final Timestamp lastMessagedAt;
  final List<dynamic> users;

  const UserMessageRoomModel({
    @required this.roomId,
    @required this.name,
    @required this.lastMessagedAt,
    @required this.users,
  });

  UserMessageRoomModel.fromMap(Map snapshot, String roomId)
      : roomId = roomId ?? '',
        name = snapshot['name'] ?? '',
        lastMessagedAt = snapshot['lastMessagedAt'],
        users = snapshot['users'];

  toJson() {
    return {
      'name': name,
      'lastMessagedAt': lastMessagedAt,
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
        createdAt = snapshot['createdAt'];

  toJson() {
    return {
      'email': email,
      'nickName': nickName,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
