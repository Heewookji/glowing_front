import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageRoomService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('messageRooms');

  Stream<QuerySnapshot> fetchMessageRoomsAsStream() {
    return _ref.orderBy('createdAt', descending: true).snapshots();
  }

  Stream<MessageRoomModel> getMessageRoomAsStream(String roomId) {
    return _ref.doc(roomId).snapshots().map(
          (doc) => MessageRoomModel.fromMap(doc.data(), doc.id),
        );
  }

  Future<MessageRoomModel> getMessageRoomByRef(DocumentReference ref) async {
    final doc = await ref.get();
    return MessageRoomModel.fromMap(doc.data(), doc.id);
  }

  Future<MessageRoomModel> getMessageRoomById(String id) async {
    final doc = await _ref.doc(id).get();
    return MessageRoomModel.fromMap(doc.data(), doc.id);
  }

  Future<List<MessageRoomModel>> getMessageRoomsByRefs(
      List<DocumentReference> refs) async {
    List<MessageRoomModel> users = List();
    for (DocumentReference ref in refs) {
      final doc = await ref.get();
      users.add(MessageRoomModel.fromMap(doc.data(), doc.id));
    }
    return users;
  }
}
