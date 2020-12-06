import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:glowing_front/core/services/firestore/message_room_service.dart';
import '../../../../locator.dart';

class MessageSendBarViewModel extends ChangeNotifier {
  User auth = getIt<FirebaseAuthService>().user;
  final controller = TextEditingController();
  final UserModel _user;
  MessageSendBarViewModel(this._user);

  void sendMessage() {
    getIt<MessageRoomService>().addMessage(
      MessageModel(
        userId: auth.uid,
        userNickName: _user.nickName,
        userImageUrl: _user.imageUrl,
        text: controller.text,
        createdAt: Timestamp.now(),
      ),
    );
  }
}
