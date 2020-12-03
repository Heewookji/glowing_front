import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_model.dart';
import 'package:glowing_front/ui/widgets/common/indicator/space_indicator.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth.dart';
import '../../../core/viewmodels/message_crud_model.dart';
import '../../../locator.dart';
import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<Auth>(context, listen: false).user;
    return StreamBuilder(
      stream: getIt<MessageCRUDModel>().fetchMessagesAsStream(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> messageSnapshot) {
        if (messageSnapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: SpaceIndicator(color: Theme.of(context).accentColor),
          );
        final messages = messageSnapshot.data.docs
            .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
            .toList();
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (ctx, index) {
            final message = messages[index];
            return MessageBubble(
              message: message,
              isMine: message.userId == currentUser.uid,
              key: ValueKey(message.id),
            );
          },
        );
      },
    );
  }
}
