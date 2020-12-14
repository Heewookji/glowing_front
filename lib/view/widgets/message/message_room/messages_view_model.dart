import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/firestore/message_service.dart';
import '../../../../locator.dart';

class MessagesViewModel extends StreamViewModel<List<MessageModel>> {
  final User auth = getIt<FirebaseAuthService>().user;
  final String roomId;
  Map<String, UserModel> userMap;
  Map<String, bool> dateDividerMap;
  List<Object> printList;
  final scrollController = ScrollController();
  bool isFetching = false;
  MessagesViewModel(this.roomId, List<UserModel> userModels) {
    userMap = Map();
    userModels.forEach((user) => userMap[user.id] = user);
    scrollController.addListener(_scrollListener);
  }

  @override
  Stream<List<MessageModel>> get stream =>
      getIt<MessageService>().getPageMessagesAsStreamByRoomId(roomId);

  @override
  List<MessageModel> transformData(List<MessageModel> messages) {
    dateDividerMap = Map();
    printList = _buildPrintList(messages);
    return messages;
  }

  List<Object> _buildPrintList(List<MessageModel> messages) {
    List ret = List();
    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      final ymd = DateFormat.yMd().format(message.createdAt.toDate());
      if (!dateDividerMap.containsKey(ymd) &&
          message.createdAt.toDate().day != DateTime.now().day) {
        dateDividerMap[ymd] = true;
        if (i != 0) ret.add(messages[i - 1].createdAt.toDate());
      }
      ret.add(message);
    }
    return ret;
  }

  void _scrollListener() {
    if (scrollController.position.atEdge &&
        !isFetching &&
        scrollController.position.pixels != 0) {
      isFetching = true;
      notifyListeners();
      getIt<MessageService>().getPageMessagesByRoomId(roomId).then(
        (messages) {
          isFetching = false;
          printList.addAll(_buildPrintList(messages));
          notifyListeners();
        },
      );
    }
  }
}
