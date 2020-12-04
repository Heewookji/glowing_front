import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:glowing_front/core/models/user_model.dart';

class MessageModel {
  final String id;
  final String text;
  final String userId;
  final String userNickName;
  final String userImageUrl;
  final Timestamp createdAt;

  MessageModel({
    this.id,
    @required this.text,
    @required this.userId,
    @required this.userNickName,
    @required this.userImageUrl,
    @required this.createdAt,
  });

  MessageModel.fromMap(Map json, String id)
      : id = id,
        text = json['text'],
        userId = json['userId'],
        userNickName = json['userNickName'],
        userImageUrl = json['userImageUrl'],
        createdAt = json['createdAt'];

  toJson() {
    return {
      'text': text,
      'userId': userId,
      'userNickName': userNickName,
      'userImageUrl': userImageUrl,
      'createdAt': createdAt,
    };
  }
}

class MessageRoomModel {
  final String id;
  final List<UserModel> users;

  MessageRoomModel({
    this.id,
    @required this.users,
  });

  factory MessageRoomModel.fromMap(Map json, String id) {
    List<dynamic> users = json['users'];
    return MessageRoomModel(
      id: id,
      users: users.map((user) => UserModel.fromMap(user, user['id'])).toList(),
    );
  }

  toJson() {
    return {};
  }
}
