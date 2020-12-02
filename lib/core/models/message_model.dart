import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageModel {
  final String id;
  final String text;
  final String userId;
  final String userNickName;
  final String userImageUrl;
  final Timestamp createdAt;

  const MessageModel({
    this.id,
    @required this.text,
    @required this.userId,
    @required this.userNickName,
    @required this.userImageUrl,
    @required this.createdAt,
  });

  MessageModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        text = snapshot['text'] ?? '',
        userId = snapshot['userId'] ?? '',
        userNickName = snapshot['userNickName'] ?? '',
        userImageUrl = snapshot['userImageUrl'] ?? '',
        createdAt = snapshot['createdAt'] ?? Timestamp.now();

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
