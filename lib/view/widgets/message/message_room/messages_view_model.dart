import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/models/message_room_model.dart';
import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/firestore/message_service.dart';
import '../../../../locator.dart';

class MessagesViewModel extends StreamViewModel<List<MessageModel>> {
  final User auth = getIt<FirebaseAuthService>().user;
  final String roomId;
  Map<String, UserModel> userMap;
  List<MessageModel> messages;

  MessagesViewModel(this.roomId, userModels) {
    userMap = Map();
    userModels.forEach((user) => userMap[user.id] = user);
  }
  @override
  Stream<List<MessageModel>> get stream =>
      getIt<MessageService>().fetchMessagesAsStreamById(roomId);
}
