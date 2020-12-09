import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:stacked/stacked.dart';

import '../../common/indicator/space_indicator.dart';
import 'message.dart';
import 'messages_view_model.dart';

class Messages extends StatelessWidget {
  final String roomId;
  final List<UserModel> userModels;
  Messages(this.roomId, this.userModels);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessagesViewModel>.reactive(
      viewModelBuilder: () => MessagesViewModel(roomId, userModels),
      builder: (ctx, model, child) {
        return !model.dataReady
            ? Center(
                child: SpaceIndicator(color: Theme.of(context).accentColor),
              )
            : ListView.builder(
                reverse: true,
                itemCount: model.messages.length,
                itemBuilder: (ctx, index) {
                  final message = model.messages[index];
                  return Message(
                    message: message,
                    isMine: model.auth.uid == message.user.id,
                    userInfo: model.userMap[message.user.id],
                    key: ValueKey(message.id),
                  );
                },
              );
      },
    );
  }
}
