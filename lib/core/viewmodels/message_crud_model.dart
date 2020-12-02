import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../services/firestore_api.dart';

class MessageCRUDModel extends ChangeNotifier {
  final FirestoreApi _firestoreApi = FirestoreApi('messages');

  List<MessageModel> _messages;

  Future<List<MessageModel>> fetchMessages() async {
    var result = await _firestoreApi.getDataCollection();
    _messages = result.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList();
    return [..._messages];
  }

  Stream<QuerySnapshot> fetchMessagesAsStream() {
    return _firestoreApi.streamDataCollection(orderBy: 'createdAt', desc: true);
  }

  Future<MessageModel> getMessageById(String id) async {
    var doc = await _firestoreApi.getDocumentById(id);
    return MessageModel.fromMap(doc.data(), doc.id);
  }

  Future removeMessage(String id) async {
    await _firestoreApi.removeDocument(id);
    return;
  }

  Future updateMessage(MessageModel data, String id) async {
    await _firestoreApi.updateDocument(data.toJson(), id);
    return;
  }

  Future addMessage(MessageModel data) async {
    var result = await _firestoreApi.addDocument(data.toJson());
    return result;
  }
}
