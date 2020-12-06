import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:glowing_front/core/services/firestore/message_service.dart';
import '../../../../locator.dart';

class MessageSendBarViewModel extends ChangeNotifier {
  User auth = getIt<FirebaseAuthService>().user;
  final controller = TextEditingController();
  final UserModel _user;
  final String _roomId;
  MessageSendBarViewModel(this._roomId, this._user);

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;
    String text = controller.text;
    controller.clear();
    getIt<MessageService>().addMessage(
      _roomId,
      MessageModel(
        userId: auth.uid,
        userNickName: _user.nickName,
        userImageUrl: _user.imageUrl,
        text: text,
        createdAt: Timestamp.now(),
      ),
    );
  }
}
