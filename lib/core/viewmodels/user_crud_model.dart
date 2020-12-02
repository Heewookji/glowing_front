import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import '../services/firestore_api.dart';

class UserCRUDModel extends ChangeNotifier {
  final FirestoreApi _firestoreApi = FirestoreApi('users');

  List<UserModel> _users;

  Future<List<UserModel>> fetchUsers() async {
    var result = await _firestoreApi.getDataCollection();
    _users = result.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
    return [..._users];
  }

  Stream<QuerySnapshot> fetchUsersAsStream() {
    return _firestoreApi.streamDataCollection();
  }

  Future<UserModel> getUserById(String id) async {
    var doc = await _firestoreApi.getDocumentById(id);
    return UserModel.fromMap(doc.data(), doc.id);
  }

  Future removeUser(String id) async {
    await _firestoreApi.removeDocument(id);
    return;
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
