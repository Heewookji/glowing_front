import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../locator.dart';

class MessageViewModel with ChangeNotifier {
  User get user {
    return getIt<FirebaseAuthService>().user;
  }

  Stream<QuerySnapshot> get messageStream {
    return null;
    //return getIt<MessageRoomService>().fetchMessagesAsStream();
  }
}
