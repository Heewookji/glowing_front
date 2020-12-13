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
    return _collection
        .where('userIds', arrayContains: userId)
        .orderBy('lastMessagedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageRoomModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<String> addMessageRoom(MessageRoomModel room) async {
    DocumentReference ref;
    if (room.isGroup) {
    } else {
      ref = await _collection.add(room.toJson());
    }
    return ref.id;
  }

  Future<void> updateUserInfo(
      String roomId, MessageRoomUserInfoModel userInfo) async {
    await _collection.doc(roomId).update({
      'userInfos.${userInfo.userId}': userInfo.toJson(),
    });
  }
}
