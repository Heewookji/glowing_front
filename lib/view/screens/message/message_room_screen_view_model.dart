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
  TextEditingController textSendBarController = TextEditingController();

  MessageRoomScreenViewModel(Map<String, Object> argument) {
    this.roomId = argument['roomId'];
    this.roomName = argument['roomName'];
    this.opponentId = argument['opponentId'];
  }

  @override
  Stream<MessageRoomModel> get stream {
    return getIt<MessageRoomService>().getMessageRoomAsStreamById(roomId);
  }

  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
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
    // 1대 1 메시지룸 개설
    if (roomId == null) {
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
      userId: auth.uid,
      text: text,
      createdAt: currentTime,
    );
    getIt<MessageRoomService>()
        .updateMessageRoom(roomId, {'lastMessagedAt': currentTime});
    textSendBarController.clear();
    initialise();
  }
}
