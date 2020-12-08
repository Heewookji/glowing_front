import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/models/message_room_model.dart';
import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/firestore/message_service.dart';
import '../../../../locator.dart';

class MessagesViewModel extends StreamViewModel<QuerySnapshot> {
  final User auth = getIt<FirebaseAuthService>().user;
  final String roomId;
  List<MessageModel> messages;

  MessagesViewModel(this.roomId);
  @override
  Stream<QuerySnapshot> get stream =>
      getIt<MessageService>().fetchMessagesAsStreamById(roomId);

  @override
  void onData(QuerySnapshot data) {
    messages = data.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList();
    super.onData(data);
  }

  Map<String, UserModel> getUsers(List<UserModel> users) {
    Map<String, UserModel> userMap = Map();
    users.forEach((user) => userMap[user.id] = user);
    return userMap;
  }
}
