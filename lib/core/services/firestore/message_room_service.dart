import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageRoomService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('messageRooms');

  Stream<QuerySnapshot> fetchMessageRoomsAsStream() {
    return _ref.orderBy('createdAt', descending: true).snapshots();
  }

  Stream<DocumentSnapshot> getMessageRoomAsStream(String roomId) {
    return _ref.doc(roomId).snapshots();
  }

  Future<MessageRoomModel> getMessageRoomByRef(DocumentReference ref) async {
    var doc = await ref.get();
    return MessageRoomModel.fromMap(doc.data(), doc.id);
  }
}
