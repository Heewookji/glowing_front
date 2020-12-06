import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class MessageRoomScreenViewModel extends FutureViewModel<UserModel> {
  final User auth = getIt<FirebaseAuthService>().user;
  String roomId;
  String roomName;

  MessageRoomScreenViewModel(Map argument) {
    this.roomId = argument['roomId'];
    this.roomName = argument['roomName'];
  }

  @override
  Future<UserModel> futureToRun() {
    return getIt<UserService>().getUserById(auth.uid);
  }
}
