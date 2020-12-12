import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/exceptions/user_exception.dart';

import '../../models/user_model.dart';

class UserService extends ChangeNotifier {
  final _collection = FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    List<UserModel> users = List();
    for (String id in ids) {
      final doc = await _collection.doc(id).get();
      users.add(UserModel.fromMap(doc.data(), doc.id));
    }
    return users;
  }

  Future<UserModel> getUserByEmail(String email) async {
    final snapshot =
        await _collection.limit(1).where('email', isEqualTo: email).get();
    if (snapshot.docs.length == 0)
      throw UserException(
          code: UserExceptionCode.NoData, message: '해당 이메일을 가진 유저가 없습니다');
    return UserModel.fromMap(snapshot.docs[0].data(), snapshot.docs[0].id);
  }

  Future addUser(UserModel user) async {
    final result = await _collection.doc(user.id).set(user.toJson());
    return result;
  }
}
