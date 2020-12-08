import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class UserService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('users');

  Stream<UserModel> fetchUserAsStreamById(String userId) {
    return _ref
        .doc(userId)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data(), doc.id));
  }

  Stream<List<String>> getUserMessageRoomIdsAsStreamById(String userId) {
    return _ref.doc(userId).snapshots().map((doc) {
      List<dynamic> init = doc.get('messageRooms');
      final messageRoomIds = init.map((ref) => ref.id as String).toList();
      return messageRoomIds;
    });
  }

  Future<List<UserModel>> getUsersByRefs(List<DocumentReference> refs) async {
    List<UserModel> users = List();
    for (DocumentReference ref in refs) {
      final doc = await ref.get();
      users.add(UserModel.fromMap(doc.data(), doc.id));
    }
    return users;
  }

  Future addUser(UserModel data) async {
    final result = await _ref.add(data.toJson());
    return result;
  }
}
