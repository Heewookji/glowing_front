import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:glowing_front/core/services/firestore/message_room_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class Opponent {
  String name;
  String imageUrl;
}

class MessageRoomListScreenViewModel extends StreamViewModel<DocumentSnapshot> {
  final User auth = getIt<FirebaseAuthService>().user;
  UserModel userModel;
  TextEditingController emailController = TextEditingController();
  List<MessageRoomModel> messageRooms;
  Map<String, List<UserModel>> messageRoomUsers = Map();
  Map<String, Opponent> messageRoomOpponent = Map();

  @override
  Stream<DocumentSnapshot> get stream =>
      getIt<UserService>().fetchUserAsStreamById(auth.uid);

  @override
  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  DocumentSnapshot transformData(DocumentSnapshot doc) {
    userModel = UserModel.fromMap(doc.data(), doc.id);
    getMessageRoomModels(userModel.messageRooms).then((newMessageRooms) {
      messageRooms = newMessageRooms;
      getUsers(messageRooms).then((_) => setBusy(false));
    });
    return super.transformData(data);
  }

  Future<List<MessageRoomModel>> getMessageRoomModels(
      List<DocumentReference> refs) async {
    List<MessageRoomModel> newMessageRooms = List();
    for (final ref in refs) {
      final messageRoom =
          await getIt<MessageRoomService>().getMessageRoomByRef(ref);
      // 새로운 메시지룸 로딩
      if (!messageRoomOpponent.containsKey(messageRoom.id))
        setBusyForObject(messageRoom, true);
      newMessageRooms.add(messageRoom);
    }
    return newMessageRooms;
  }

  Future<void> getUsers(List<MessageRoomModel> messageRooms) async {
    for (MessageRoomModel messageRoom in messageRooms) {
      final users =
          await getIt<UserService>().getUsersByRefs(messageRoom.users);
      messageRoomUsers[messageRoom.id] = users;
      setOpponent(messageRoom);
      setBusyForObject(messageRoom, false);
    }
  }

  void setOpponent(MessageRoomModel messageRoom) {
    final opponent = Opponent();
    if (messageRoom.isGroup) {
      //group 톡 일경우
    } else {
      messageRoomUsers[messageRoom.id].forEach((user) {
        if (user.id != auth.uid) {
          opponent.imageUrl = user.imageUrl;
          opponent.name = user.nickName;
        }
      });
    }
    messageRoomOpponent[messageRoom.id] = opponent;
  }
}
