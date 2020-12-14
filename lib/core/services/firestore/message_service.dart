import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_model.dart';

class MessageService extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('messageRooms');
  final int pageCount = 7;
  DocumentSnapshot lastDocumentOfPage;

  void addMessage(String roomId, MessageModel message) {
    WriteBatch batch = _db.batch();
    batch.set(
        _collection.doc(roomId).collection('messages').doc(), message.toJson());
    batch.update(_collection.doc(roomId), {
      'lastMessagedAt': message.createdAt,
      'lastMessagedText': message.text,
    });
    batch.commit();
  }

  Stream<List<MessageModel>> getPageMessagesAsStreamByRoomId(String roomId) {
    return _collection
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(pageCount)
        .snapshots()
        .map((snapshot) {
      final ret = snapshot.docs
          .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
          .toList();
      lastDocumentOfPage = snapshot.docs[snapshot.docs.length - 1];
      return ret;
    });
  }

  Future<List<MessageModel>> getPageMessagesByRoomId(String roomId) async {
    final snapshot = await _collection
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(pageCount)
        .startAfterDocument(lastDocumentOfPage)
        .get();
    if (snapshot.docs.length == 0) return List();
    final ret = snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList();
    lastDocumentOfPage = snapshot.docs.last;
    return ret;
  }
}
