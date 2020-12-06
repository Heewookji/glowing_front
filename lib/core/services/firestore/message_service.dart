import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('messageRooms');

  Future addMessage(String roomId, MessageModel data) async {
    var result =
        await _ref.doc(roomId).collection('messages').add(data.toJson());
    return result;
  }

  Stream<QuerySnapshot> fetchMessagesAsStream(roomId) {
    return _ref
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
