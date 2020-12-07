import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/message_room_model.dart';
import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/firestore/message_service.dart';
import '../../../../locator.dart';

class MessageSendBarViewModel extends ChangeNotifier {
  User auth = getIt<FirebaseAuthService>().user;
  final controller = TextEditingController();
  final String _roomId;
  MessageSendBarViewModel(this._roomId);

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;
    String text = controller.text;
    controller.clear();
    getIt<MessageService>().addMessage(
      _roomId,
      MessageModel(
        userId: auth.uid,
        text: text,
        createdAt: Timestamp.now(),
      ),
    );
  }
}
