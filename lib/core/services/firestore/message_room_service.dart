import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageRoomService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('messageRooms');

  Stream<MessageRoomModel> getMessageRoomAsStreamById(String roomId) {
    return _ref.doc(roomId).snapshots().map(
          (doc) => MessageRoomModel.fromMap(doc.data(), doc.id),
        );
  }

  Future<MessageRoomModel> getMessageRoomByRef(DocumentReference ref) async {
    final doc = await ref.get();
    return MessageRoomModel.fromMap(doc.data(), doc.id);
  }
}
