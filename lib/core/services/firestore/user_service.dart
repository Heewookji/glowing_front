import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class UserService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('users');

  Stream<DocumentSnapshot> fetchUserAsStreamById(userId) {
    return _ref.doc(userId).snapshots();
  }

  Future<List<UserModel>> getUsersByRefs(List<DocumentReference> refs) async {
    List<UserModel> users = List();
    for (DocumentReference ref in refs) {
      var doc = await ref.get();
      users.add(UserModel.fromMap(doc.data(), doc.id));
    }
    return users;
  }

  Future addUser(UserModel data) async {
    var result = await _ref.add(data.toJson());
    return result;
  }
}
