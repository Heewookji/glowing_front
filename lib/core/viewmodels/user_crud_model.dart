import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/firestore_api.dart';

class UserCRUDModel extends ChangeNotifier {
  final FirestoreApi firestoreApi;
  UserCRUDModel(this.firestoreApi);

  Future<List<UserModel>> fetchUsers() async {
    var result = await firestoreApi.getDataCollection();
    return result.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Stream<QuerySnapshot> fetchUsersAsStream() {
    return firestoreApi.streamDataCollection();
  }

  Future<UserModel> getUserById(String id) async {
    var doc = await firestoreApi.getDocumentById(id);
    return UserModel.fromMap(doc.data(), doc.id);
  }

  Future removeUser(String id) async {
    await firestoreApi.removeDocument(id);
    return;
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
