import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageService extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('messageRooms');

  void addMessage(
    String roomId, {
    @required String userId,
    @required String text,
    @required Timestamp createdAt,
  }) {
    WriteBatch batch = _db.batch();
    final message = MessageModel(
      text: text,
      userId: userId,
      createdAt: createdAt,
    );
    batch.set(
        _collection.doc(roomId).collection('messages').doc(), message.toJson());
    batch.update(_collection.doc(roomId), {'lastMessagedAt': createdAt});
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
