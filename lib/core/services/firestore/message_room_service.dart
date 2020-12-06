import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';

import 'firestore_api.dart';

class MessageRoomService extends ChangeNotifier {
  final FirestoreApi _firestoreApi = FirestoreApi('messageRooms');

  Stream<QuerySnapshot> fetchMessageRoomsAsStream() {
    return _firestoreApi.streamDataCollection(orderBy: 'createdAt', desc: true);
  }

  Future<MessageRoomModel> getMessageRoomsById(String id) async {
    var doc = await _firestoreApi.getDocumentById(id);
    return MessageRoomModel.fromMap(doc.data(), doc.id);
  }

  Future removeMessageRooms(String id) async {
    await _firestoreApi.removeDocument(id);
    return;
  }

  Future updateMessageRooms(MessageRoomModel data, String id) async {
    await _firestoreApi.updateDocument(data.toJson(), id);
    return;
  }

  Future addMessageRooms(MessageRoomModel data) async {
    var result = await _firestoreApi.addDocument(data.toJson());
    return result;
  }

  Future addMessage(MessageModel data) async {
    var result = await _firestoreApi.addDocument(data.toJson());
    return result;
  }

  Stream<QuerySnapshot> fetchMessagesAsStream(roomId) {
    return _firestoreApi.streamDataSecondaryCollection(roomId, 'messages',
        orderBy: 'createdAt', desc: true);
  }
}
