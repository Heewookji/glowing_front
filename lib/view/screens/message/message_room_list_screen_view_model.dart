import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class Opponent {
  String nickName;
  String imageUrl;
}

class MessageRoomListScreenViewModel extends StreamViewModel<QuerySnapshot> {
  final User auth = getIt<FirebaseAuthService>().user;
  TextEditingController emailController = TextEditingController();
  List<UserMessageRoomModel> messageRooms;
  Map<String, List<UserModel>> messageRoomUsers;

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
    //스트림 데이터 변화 로딩
    setBusy(true);
    messageRoomUsers = Map();
    messageRooms = data.docs.map((doc) {
      return UserMessageRoomModel.fromMap(doc.data(), doc.id);
    }).toList();
    getUsers(messageRooms).then((_) => setBusy(false));
    return super.transformData(data);
  }

  Future<void> getUsers(List<UserMessageRoomModel> messageRooms) async {
    for (UserMessageRoomModel messageRoom in messageRooms) {
      final users = await getIt<UserService>().getUsersByIds(messageRoom.users);
      messageRoomUsers[messageRoom.roomId] = users;
    }
  }

  Opponent getOpponent(UserMessageRoomModel messageRoom) {
    final opponent = Opponent();
    if (messageRoom.isGroup) {
      //group 톡 일경우
    } else {
      messageRoomUsers[messageRoom.roomId].forEach((user) {
        if (user.id != auth.uid) {
          opponent.imageUrl = user.imageUrl;
          opponent.nickName = user.nickName;
        }
      });
    }
    return opponent;
  }
}
