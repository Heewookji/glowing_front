import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class UserService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> fetchUserMessageRoomsAsStreamById(userId) {
    return _ref.doc(userId).collection('messageRooms').snapshots();
  }

  Future<UserModel> getUserById(String id) async {
    var doc = await _ref.doc(id).get();
    return UserModel.fromMap(doc.data(), doc.id);
  }

  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    List<UserModel> users = List();
    for (String id in ids) {
      var doc = await _ref.doc(id).get();
      users.add(UserModel.fromMap(doc.data(), doc.id));
    }
    return users;
  }

  Future addUser(UserModel data) async {
    var result = await _ref.add(data.toJson());
    return result;
  }
}
