import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:stacked/stacked.dart';

import 'messages_view_model.dart';

class Message extends ViewModelWidget<MessagesViewModel> {
  Message({
    @required this.message,
    @required this.isMine,
    @required this.key,
  });
  final Key key;
  final bool isMine;
  final MessageModel message;

  @override
  Widget build(BuildContext context, MessagesViewModel model) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMine = model.auth.uid == message.userId;
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMine) _buildAvatar(screenWidth, screenHeight),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMine) _buildNickName(),
              _buildTextContainer(screenWidth, context),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildNickName() {
    return Container(
      child: Text(
        '',
        //message.userNickName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container _buildTextContainer(double screenWidth, BuildContext context) {
    return Container(
      width: screenWidth * 0.35,
      decoration: BoxDecoration(
        color: !isMine
            ? Theme.of(context).backgroundColor
            : Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: !isMine ? Radius.circular(0) : Radius.circular(12),
          topRight: isMine ? Radius.circular(0) : Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      margin: EdgeInsets.only(
        top: 5,
        bottom: 15,
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: isMine
              ? Colors.black
              : Theme.of(context).accentTextTheme.headline6.color,
        ),
        textAlign: isMine ? TextAlign.end : TextAlign.start,
      ),
    );
  }

  Container _buildAvatar(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(left: screenWidth * 0.03),
      child: Column(
        children: [
          CircleAvatar(
              //backgroundImage: NetworkImage(),
              ),
          SizedBox(
            height: screenHeight * 0.04,
          )
        ],
      ),
    );
  }
}
