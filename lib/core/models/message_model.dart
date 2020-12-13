import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:glowing_front/core/models/model.dart';

class MessageModel implements Model {
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
