import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/models/message_room_model.dart';
import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/firestore/message_service.dart';
import '../../../../locator.dart';

class MessagesViewModel extends StreamViewModel<List<MessageModel>> {
  final User auth = getIt<FirebaseAuthService>().user;
  final String roomId;
  Map<String, UserModel> userMap;
  Map<String, bool> dateDividerMap;
  List<Object> printList;

  MessagesViewModel(this.roomId, List<UserModel> userModels) {
    userMap = Map();
    userModels.forEach((user) => userMap[user.id] = user);
  }
  @override
  Stream<List<MessageModel>> get stream =>
      getIt<MessageService>().fetchMessagesAsStreamById(roomId);

  @override
  List<MessageModel> transformData(List<MessageModel> messages) {
    dateDividerMap = Map();
    printList = List();
    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      final ymd = DateFormat.yMd().format(message.createdAt.toDate());
      if (message.createdAt.toDate().day != DateTime.now().day &&
          !dateDividerMap.containsKey(ymd)) {
        dateDividerMap[ymd] = true;
        printList.add(
          message.createdAt.toDate().add(
                Duration(days: 1),
              ),
        );
      }
      printList.add(message);
    }
    return messages;
  }
}
