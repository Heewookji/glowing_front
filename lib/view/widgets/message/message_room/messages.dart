import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/view/widgets/message/message_room/messages_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/message_room_model.dart';
import '../../common/indicator/space_indicator.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MessageViewModel>(context);
    return StreamBuilder(
      stream: null,
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
              isMine: true, //message.userId == currentUser.uid,
              key: ValueKey(message.id),
            );
          },
        );
      },
    );
  }
}
