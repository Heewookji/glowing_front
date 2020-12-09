import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/exceptions/user_exception.dart';
import 'package:glowing_front/core/utils/convert_helper.dart';
import '../../models/user_model.dart';

class UserService extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('users');

  Stream<UserModel> getUserAsStreamById(String userId) {
    return _ref
        .doc(userId)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data(), doc.id));
  }

  Stream<List<DocumentReference>> getUserMessageRoomRefsAsStreamById(
      String userId) {
    return _ref.doc(userId).snapshots().map((doc) {
      return ConvertHelper.dynamicToDocRefList(doc.get('messageRooms'));
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

  Future<UserModel> getUserByEmail(String email) async {
    final snapshot = await _ref.limit(1).where('email', isEqualTo: email).get();
    if (snapshot.docs.length == 0)
      throw UserException(
          code: UserExceptionCode.NoData, message: '해당 이메일을 가진 유저가 없습니다');
    return UserModel.fromMap(snapshot.docs[0].data(), snapshot.docs[0].id);
  }

  Future addUser(UserModel data) async {
    final result = await _ref.add(data.toJson());
    return result;
  }
}
