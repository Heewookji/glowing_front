import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/user_model.dart';
import '../../../core/services/auth/firebase_auth_service.dart';
import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class MessageRoomScreenViewModel extends FutureViewModel<UserModel> {
  final User auth = getIt<FirebaseAuthService>().user;
  String roomId;
  String roomName;
  List<UserModel> users;

  MessageRoomScreenViewModel(Map argument) {
    this.roomId = argument['roomId'];
    this.roomName = argument['roomName'];
    this.users = argument['users'];
  }

  @override
  Future<UserModel> futureToRun() {
    return getIt<UserService>().getUserById(auth.uid);
  }
}
