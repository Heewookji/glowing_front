import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('messageRooms');

  Future addMessage(
    String roomId, {
    @required String userId,
    @required String text,
    @required Timestamp createdAt,
  }) async {
    final message = MessageModel(
      text: text,
      user: FirebaseFirestore.instance.collection('users').doc(userId),
      createdAt: createdAt,
    );
    final result =
        await _ref.doc(roomId).collection('messages').add(message.toJson());
    return result;
  }

  Stream<QuerySnapshot> fetchMessagesAsStreamById(String roomId) {
    return _ref
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
