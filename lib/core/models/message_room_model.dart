import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageModel {
  final String id;
  final String text;
  final DocumentReference user;
  final Timestamp createdAt;

  MessageModel({
    this.id,
    @required this.text,
    @required this.user,
    @required this.createdAt,
  });

  MessageModel.fromMap(Map json, String id)
      : id = id ?? '',
        text = json['text'] ?? '',
        user = json['user'],
        createdAt = json['createdAt'] ?? Timestamp.fromDate(DateTime(9999));

  toJson() {
    return {
      'text': text,
      'user': user,
      'createdAt': createdAt,
    };
  }
}

class MessageRoomModel {
  final String id;
  final bool isGroup;
  final Timestamp lastMessagedAt;
  final List<DocumentReference> users;

  MessageRoomModel({
    this.id,
    @required this.isGroup,
    @required this.lastMessagedAt,
    @required this.users,
  });

  factory MessageRoomModel.fromMap(Map json, String id) {
    List<dynamic> users = json['users'];
    return MessageRoomModel(
      id: id ?? '',
      isGroup: json['isGroup'] ?? false,
      lastMessagedAt:
          json['lastMessagedAt'] ?? Timestamp.fromDate(DateTime(1900)),
      users: users == null
          ? List()
          : users.map((user) => user as DocumentReference).toList(),
    );
  }

  toJson() {
    return {};
  }
}
