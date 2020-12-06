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
  Map<String, List<UserModel>> messageRoomUsers;
  @override
  Stream<QuerySnapshot> get stream {
    return getIt<UserService>().fetchUserMessageRoomsAsStreamById(auth.uid);
  }

  // onData가 끝나길 기다리지 않는다. model.dataReady(stream)만 플래그 뜨면 바로 출력한다.
  @override
  void onData(QuerySnapshot data) async {
    messageRoomUsers = Map();
    messageRooms = data.docs.map((doc) {
      return UserMessageRoomModel.fromMap(doc.data(), doc.id);
    }).toList();
    for (UserMessageRoomModel messageRoom in messageRooms) {
      getIt<UserService>()
          .getUsersByIds(messageRoom.users)
          .then((users) => messageRoomUsers[messageRoom.roomId] = users);
    }
    super.onData(data);
  }
}
