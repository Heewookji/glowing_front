import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/firestore/message_room_service.dart';
import 'package:glowing_front/core/services/firestore/message_service.dart';
import 'package:glowing_front/core/services/firestore/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/auth/firebase_auth_service.dart';
import '../../../locator.dart';

class MessageRoomScreenViewModel extends StreamViewModel<MessageRoomModel> {
  final User auth = getIt<FirebaseAuthService>().user;
  List<UserModel> users;
  String roomId;
  String roomName;
  String opponentId;
  bool notExistRoom;
  TextEditingController textSendBarController = TextEditingController();

  MessageRoomScreenViewModel(Map<String, Object> argument) {
    this.roomId = argument['roomId'];
    this.roomName = argument['roomName'];
    this.opponentId = argument['opponentId'];
    this.notExistRoom = this.roomId == null;
  }

  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  Stream<MessageRoomModel> get stream {
    return getIt<MessageRoomService>().getMessageRoomAsStreamById(roomId);
  }

  @override
  MessageRoomModel transformData(MessageRoomModel messageRoomModel) {
    getIt<UserService>()
        .getUsersByIds(messageRoomModel.users)
        .then((newUserModels) {
      users = newUserModels;
      setBusy(false);
    });
    return super.transformData(messageRoomModel);
  }

  void sendMessage() async {
    final text = textSendBarController.text;
    if (text.trim().isEmpty) return;
    final currentTime = Timestamp.now();

    if (notExistRoom) {
      final userIds = [auth.uid, opponentId];
      roomId = await getIt<MessageRoomService>().addMessageRoom(
        room: MessageRoomModel(
          isGroup: false,
          lastMessagedAt: currentTime,
          users: userIds,
        ),
      );
    }
    getIt<MessageService>().addMessage(
      roomId,
      MessageModel(
        userId: auth.uid,
        text: text,
        createdAt: currentTime,
      ),
    );
    textSendBarController.clear();
    if (notExistRoom) {
      notExistRoom = false;
      initialise();
    }
  }
}
