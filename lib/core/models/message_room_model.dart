import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:glowing_front/core/models/user_model.dart';

class MessageModel {
  final String id;
  final String text;
  final String userId;
  final Timestamp createdAt;

  MessageModel({
    this.id,
    @required this.text,
    @required this.userId,
    @required this.createdAt,
  });

  MessageModel.fromMap(Map json, String id)
      : id = id ?? '',
        text = json['text'] ?? '',
        userId = json['userId'] ?? '',
        createdAt = json['createdAt'] ?? Timestamp.fromDate(DateTime(9999));

  toJson() {
    return {
      'text': text,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}

class MessageRoomModel {
  final String id;
  final bool isGroup;
  final List<DocumentReference> users;

  MessageRoomModel({
    this.id,
    @required this.isGroup,
    @required this.users,
  });

  factory MessageRoomModel.fromMap(Map json, String id) {
    List<dynamic> users = json['users'];
    return MessageRoomModel(
      id: id ?? '',
      isGroup: json['isGroup'] ?? false,
      users: users == null
          ? List()
          : users.map((user) => user as DocumentReference).toList(),
    );
  }

  toJson() {
    return {};
  }
}
