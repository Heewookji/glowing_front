import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:glowing_front/core/utils/convert_helper.dart';

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
        userId = json['userId'],
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
  final Timestamp lastMessagedAt;
  final List<String> users;

  MessageRoomModel({
    this.id,
    @required this.isGroup,
    @required this.lastMessagedAt,
    @required this.users,
  });

  factory MessageRoomModel.fromMap(Map json, String id) {
    return MessageRoomModel(
      id: id ?? '',
      isGroup: json['isGroup'] ?? false,
      lastMessagedAt:
          json['lastMessagedAt'] ?? Timestamp.fromDate(DateTime(1900)),
      users: json['users'] == null
          ? List()
          : ConvertHelper.dynamicToStringList(json['users']),
    );
  }

  toJson() {
    return {
      'isGroup': isGroup,
      'users': users,
      'lastMessagedAt': lastMessagedAt,
    };
  }
}
