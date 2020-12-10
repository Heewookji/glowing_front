import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

class MessageRoomService extends ChangeNotifier {
  final _collection = FirebaseFirestore.instance.collection('messageRooms');

  Stream<MessageRoomModel> getMessageRoomAsStreamById(String roomId) {
    return _collection.doc(roomId).snapshots().map(
          (doc) => MessageRoomModel.fromMap(doc.data(), doc.id),
        );
  }

  Stream<List<MessageRoomModel>> getMessageRoomsAsStreamByUserId(
      String userId) {
    return _collection.where('users', arrayContains: userId).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageRoomModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<String> addMessageRoom({@required MessageRoomModel room}) async {
    DocumentReference ref;
    if (room.isGroup) {
    } else {
      final messageRoom = MessageRoomModel(
        isGroup: false,
        users: room.users,
        lastMessagedAt: room.lastMessagedAt,
      );
      ref = await _collection.add(messageRoom.toJson());
    }
    return ref.id;
  }

  Future<void> updateMessageRoom(String roomId, Map<String, dynamic> map) async {
    await _collection.doc(roomId).update(map);
  }
}
