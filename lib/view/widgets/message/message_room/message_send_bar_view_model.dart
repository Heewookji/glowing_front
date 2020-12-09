import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/services/firestore/message_room_service.dart';
import 'package:glowing_front/core/services/firestore/user_service.dart';

import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/firestore/message_service.dart';
import '../../../../locator.dart';

class MessageSendBarViewModel extends ChangeNotifier {
  User auth = getIt<FirebaseAuthService>().user;
  final controller = TextEditingController();
  String roomId;
  final String opponentId;
  MessageSendBarViewModel(this.roomId, this.opponentId);

  void sendMessage() async {
    if (controller.text.trim().isEmpty) return;
    // 1대 1 메시지룸 개설
    if (roomId == null) {
      final userIds = [auth.uid, opponentId];
      roomId = await getIt<MessageRoomService>()
          .addOneOnOneMessageRoom(userIds: userIds);
      await getIt<UserService>().addUsersMessageRoom(userIds, roomId);
    }
    getIt<MessageService>().addMessage(
      roomId,
      userId: auth.uid,
      text: controller.text,
      createdAt: Timestamp.now(),
    );
    controller.clear();
  }
}
