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

class MessagesViewModel extends StreamViewModel<MessageModel> {
  final User auth = getIt<FirebaseAuthService>().user;
  final String roomId;
  Map<String, UserModel> userMap;
  List<Object> printList;
  List<MessageModel> messages;
  final scrollController = ScrollController();
  bool isFetching = false;

  MessagesViewModel(this.roomId, List<UserModel> userModels) {
    userMap = Map();
    userModels.forEach((user) => userMap[user.id] = user);
    scrollController.addListener(_addPastMessagesByScroll);
    messages = List();
  }

  @override
  void initialise() {
    setBusy(true);
    super.initialise();
  }

  @override
  Stream<MessageModel> get stream =>
      getIt<MessageService>().getTopOneMessageAsStreamByRoomId(roomId);

  @override
  MessageModel transformData(MessageModel newMessage) {
    _addNewMessage(newMessage).then((value) => setBusy(false));
    return newMessage;
  }

  Future<void> _addNewMessage(MessageModel newMessage) async {
    if (messages.length != 0 && newMessage.id == messages[0].id) return;
    messages.insert(0, newMessage);
    if (messages.length == 1) {
      final pageMessages = await getIt<MessageService>()
          .getPageMessagesByRoomId(roomId, isFirst: true);
      messages.addAll(pageMessages);
    }
    _buildPrintList(messages);
  }

  void _addPastMessagesByScroll() async {
    if (scrollController.position.atEdge &&
        !isFetching &&
        scrollController.position.pixels > 0) {
      isFetching = true;
      notifyListeners();
      final pageMessages =
          await getIt<MessageService>().getPageMessagesByRoomId(roomId);
      messages.addAll(pageMessages);
      _buildPrintList(messages);
      isFetching = false;
      notifyListeners();
    }
  }

  void _buildPrintList(List<MessageModel> messages) {
    List newList = List();
    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      newList.add(message);
      if (i == messages.length - 1 ||
          DateFormat.yMd().format(messages[i + 1].createdAt) !=
              DateFormat.yMd().format(messages[i].createdAt)) {
        newList.add(messages[i].createdAt);
      }
    }
    printList = newList;
  }

  bool isSameMinutes(MessageModel one, Object another) {
    if (another is DateTime) return false;
    MessageModel anotherMessage = another;
    String oneHm = DateFormat.Hm().format(one.createdAt);
    String anotherHm = DateFormat.Hm().format(anotherMessage.createdAt);
    return one.userId == anotherMessage.userId && oneHm == anotherHm;
  }
}
