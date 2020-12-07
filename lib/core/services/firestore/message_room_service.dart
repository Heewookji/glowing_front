import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageRoomService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('messageRooms');

  Stream<QuerySnapshot> fetchMessageRoomsAsStream() {
    return _ref.orderBy('createdAt', descending: true).snapshots();
  }

    Stream<QuerySnapshot> getUsersAsStream() {
    return _ref.orderBy('createdAt', descending: true).snapshots();
  }

  Future<MessageRoomModel> getMessageRoomById(String id) async {
    var doc = await _ref.doc(id).get();
    return MessageRoomModel.fromMap(doc.data(), doc.id);
  }
}
