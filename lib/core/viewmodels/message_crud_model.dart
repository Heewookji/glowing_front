import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../services/firestore_api.dart';

class MessageCRUDModel extends ChangeNotifier {
  final FirestoreApi firestoreApi;
  MessageCRUDModel(this.firestoreApi);

  Future<List<MessageModel>> fetchMessages() async {
    var result = await firestoreApi.getDataCollection();
    return result.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Stream<QuerySnapshot> fetchMessagesAsStream() {
    return firestoreApi.streamDataCollection(orderBy: 'createdAt', desc: true);
  }

  Future<MessageModel> getMessageById(String id) async {
    var doc = await firestoreApi.getDocumentById(id);
    return MessageModel.fromMap(doc.data(), doc.id);
  }

  Future removeMessage(String id) async {
    await firestoreApi.removeDocument(id);
    return;
  }

  Future updateMessage(MessageModel data, String id) async {
    await firestoreApi.updateDocument(data.toJson(), id);
    return;
  }

  Future addMessage(MessageModel data) async {
    var result = await firestoreApi.addDocument(data.toJson());
    return result;
  }
}
