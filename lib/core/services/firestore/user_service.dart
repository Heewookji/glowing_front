import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import 'firestore_api.dart';

class UserService extends ChangeNotifier {
  final FirestoreApi firestoreApi = FirestoreApi('users');
  UserService();

  Stream<QuerySnapshot> fetchUserMessageRoomsAsStreamById(userId) {
    return firestoreApi.streamDataSecondaryCollection(userId, 'messageRooms');
  }

  Future<UserModel> getUserById(String id) async {
    var doc = await firestoreApi.getDocumentById(id);
    return UserModel.fromMap(doc.data(), doc.id);
  }

  Future updateUser(UserModel data, String id) async {
    await firestoreApi.updateDocument(data.toJson(), id);
    return;
  }

  Future addUser(UserModel data) async {
    var result = await firestoreApi.addDocumentById(data.toJson(), data.id);
    return result;
  }
}
