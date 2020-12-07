import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/firestore/message_room_service.dart';
import 'package:glowing_front/core/services/firestore/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/auth/firebase_auth_service.dart';
import '../../../locator.dart';

class MessageRoomScreenViewModel extends StreamViewModel<DocumentSnapshot> {
  final User auth = getIt<FirebaseAuthService>().user;
  MessageRoomModel messageRoomModel;
  List<UserModel> users;
  String roomId;
  String roomName;

  MessageRoomScreenViewModel(Map<String, Object> argument) {
    this.roomId = argument['roomId'];
    this.roomName = argument['roomName'];
  }

  @override
  Stream<DocumentSnapshot> get stream =>
      getIt<MessageRoomService>().getMessageRoomAsStream(roomId);

  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  DocumentSnapshot transformData(DocumentSnapshot doc) {
    messageRoomModel = MessageRoomModel.fromMap(doc.data(), doc.id);
    getIt<UserService>()
        .getUsersByRefs(messageRoomModel.users)
        .then((newUserModels) {
      users = newUserModels;
      setBusy(false);
    });
    return super.transformData(data);
  }
}
