import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:intl/intl.dart';
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
        ThemeData theme = Theme.of(context);
        Size screenSize = MediaQuery.of(context).size;
        return model.isBusy
            ? Center(
                child: SpaceIndicator(color: Theme.of(context).accentColor),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: model.printList.length,
                controller: model.scrollController,
                itemBuilder: (ctx, index) {
                  final printObject = model.printList[index];
                  if (printObject is DateTime) {
                    DateTime createdAt = printObject;
                    return _buildDivider(
                        createdAt, screenSize, theme.textTheme.caption);
                  }
                  MessageModel message = printObject;
                  return Column(
                    children: [
                      index == model.printList.length - 1
                          ? _buildIsFetchingIndicator(screenSize, model, theme)
                          : Container(),
                      Message(
                        message: message,
                        isMine: model.auth.uid == message.userId,
                        userInfo: model.userMap[message.userId],
                        key: ValueKey(message.id),
                      ),
                    ],
                  );
                },
              );
      },
    );
  }

  Container _buildIsFetchingIndicator(
      Size screenSize, MessagesViewModel model, ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.04),
      child: model.isFetching ? SpaceIndicator(color: theme.accentColor) : null,
    );
  }

  Widget _buildDivider(DateTime dateTime, Size screenSize, TextStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.06),
      child: Column(
        children: [
          Divider(),
          Text(
            DateFormat.yMEd().format(dateTime),
            style: style,
          ),
        ],
      ),
    );
  }
}
