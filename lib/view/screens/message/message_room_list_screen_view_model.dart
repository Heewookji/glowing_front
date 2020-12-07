import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class Opponent {
  String name;
  String imageUrl;
}

class MessageRoomListScreenViewModel extends StreamViewModel<QuerySnapshot> {
  final User auth = getIt<FirebaseAuthService>().user;
  TextEditingController emailController = TextEditingController();
  List<UserMessageRoomModel> messageRooms;
  Map<String, List<UserModel>> messageRoomUsers = Map();
  Map<String, Opponent> messageRoomOpponent = Map();

  @override
  Stream<QuerySnapshot> get stream =>
      getIt<UserService>().fetchUserMessageRoomsAsStreamById(auth.uid);

  @override
  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  QuerySnapshot transformData(QuerySnapshot data) {
    messageRooms = data.docs.map((doc) {
      final roomId = doc.id;
      final userMessageRoomModel =
          UserMessageRoomModel.fromMap(doc.data(), roomId);
      if (messageRoomOpponent != null &&
          !messageRoomOpponent.containsKey(roomId))
        setBusyForObject(userMessageRoomModel, true);
      return userMessageRoomModel;
    }).toList();
    getUsers(messageRooms).then((_) => setBusy(false));
    return super.transformData(data);
  }

  Future<void> getUsers(List<UserMessageRoomModel> messageRooms) async {
    for (UserMessageRoomModel messageRoom in messageRooms) {
      final users = await getIt<UserService>().getUsersByIds(messageRoom.users);
      messageRoomUsers[messageRoom.roomId] = users;
      setOpponent(messageRoom);
      setBusyForObject(messageRoom, false);
    }
  }

  void setOpponent(UserMessageRoomModel messageRoom) {
    final opponent = Opponent();
    if (messageRoom.isGroup) {
      //group 톡 일경우
    } else {
      messageRoomUsers[messageRoom.roomId].forEach((user) {
        if (user.id != auth.uid) {
          opponent.imageUrl = user.imageUrl;
          opponent.name = user.nickName;
        }
      });
    }
    messageRoomOpponent[messageRoom.roomId] = opponent;
  }
}
