import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/utils/convert_helper.dart';
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
      final messageRoomIds =
          ConvertHelper.dynamicToDocRefList(doc.get('messageRooms'))
              .map((ref) => ref.id)
              .toList();
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
