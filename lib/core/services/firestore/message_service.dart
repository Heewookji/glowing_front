import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageService extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('messageRooms');

  void addMessage(String roomId, MessageModel message) {
    WriteBatch batch = _db.batch();
    batch.set(
        _collection.doc(roomId).collection('messages').doc(), message.toJson());
    batch
        .update(_collection.doc(roomId), {'lastMessagedAt': message.createdAt});
    batch.commit();
  }

  Stream<List<MessageModel>> fetchMessagesAsStreamById(String roomId) {
    return _collection
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
}
