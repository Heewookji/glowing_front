import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/services/firestore/message_room_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/message_room_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/auth/firebase_auth_service.dart';
import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class Opponent {
  String name;
  String imageUrl;
}

class MessageRoomListScreenViewModel extends StreamViewModel<List<String>> {
  final User auth = getIt<FirebaseAuthService>().user;
  TextEditingController emailController = TextEditingController();
  List<MessageRoomModel> messageRooms;
  Map<String, List<UserModel>> messageRoomUsers = Map();
  Map<String, Opponent> messageRoomOpponent = Map();

  @override
  Stream<List<String>> get stream =>
      getIt<UserService>().getUserMessageRoomIdsAsStreamById(auth.uid);

  @override
  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  List<String> transformData(List<String> roomIds) {
    getMessageRooms(roomIds);
    return super.transformData(roomIds);
  }

  void getMessageRooms(List<String> roomIds) async {
    List<MessageRoomModel> rooms = List();
    for (final roomId in roomIds) {
      final room = await getIt<MessageRoomService>().getMessageRoomById(roomId);
      rooms.add(room);
      await getUsers(room);
    }
    messageRooms = rooms;
    setBusy(false);
  }

  Future<void> getUsers(MessageRoomModel messageRoom) async {
    messageRoomUsers[messageRoom.id] =
        await getIt<UserService>().getUsersByRefs(messageRoom.users);
    setOpponent(messageRoom);
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
