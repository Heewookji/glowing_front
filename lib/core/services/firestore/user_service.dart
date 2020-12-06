import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import 'firestore_api.dart';

class UserService extends ChangeNotifier {
  final FirestoreApi _firestoreApi = FirestoreApi('users');

  Stream<QuerySnapshot> fetchUserMessageRoomsAsStreamById(userId) {
    return _firestoreApi.streamDataSecondaryCollection(userId, 'messageRooms');
  }

  Future<UserModel> getUserById(String id) async {
    var doc = await _firestoreApi.getDocumentById(id);
    return UserModel.fromMap(doc.data(), doc.id);
  }

  Future updateUser(UserModel data, String id) async {
    await _firestoreApi.updateDocument(data.toJson(), id);
    return;
  }

  Future addUser(UserModel data) async {
    var result = await _firestoreApi.addDocumentById(data.toJson(), data.id);
    return result;
  }
}
