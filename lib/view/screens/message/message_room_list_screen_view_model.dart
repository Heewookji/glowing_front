import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:glowing_front/core/services/firestore/user_service.dart';

import '../../../locator.dart';

class MessageRoomListScreenViewModel extends ChangeNotifier {
  User _user;

  void init() {
    _user = getIt<FirebaseAuthService>().user;
  }

  Stream<QuerySnapshot> get userMessageRoomStream {
    return getIt<UserService>().fetchUserMessageRoomsAsStreamById(_user.uid);
  }
}
