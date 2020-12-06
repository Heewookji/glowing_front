import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:glowing_front/core/services/firestore/message_service.dart';
import 'package:stacked/stacked.dart';

import '../../../../locator.dart';

class MessagesViewModel extends StreamViewModel<QuerySnapshot> {
  final User auth = getIt<FirebaseAuthService>().user;
  final String roomId;

  MessagesViewModel(this.roomId);
  @override
  Stream<QuerySnapshot> get stream =>
      getIt<MessageService>().fetchMessagesAsStream(roomId);

  List<MessageModel> get messages =>
      data.docs.map((doc) => MessageModel.fromMap(doc.data(), doc.id)).toList();
}
