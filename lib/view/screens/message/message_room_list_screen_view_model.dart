import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class MessageRoomListScreenViewModel extends StreamViewModel<QuerySnapshot> {
  final User auth = getIt<FirebaseAuthService>().user;
  TextEditingController emailController = TextEditingController();
  List<UserMessageRoomModel> messageRooms;
  @override
  Stream<QuerySnapshot> get stream =>
      getIt<UserService>().fetchUserMessageRoomsAsStreamById(auth.uid);
  @override
  void onData(QuerySnapshot data) {
    messageRooms = data.docs
        .map((doc) => UserMessageRoomModel.fromMap(doc.data(), doc.id))
        .toList();
    super.onData(data);
  }
}
