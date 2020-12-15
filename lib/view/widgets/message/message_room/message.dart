import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:intl/intl.dart';

class Message extends StatelessWidget {
  Message({
    @required this.message,
    @required this.isMine,
    @required this.userInfo,
    @required this.key,
  });
  final Key key;
  final bool isMine;
  final UserModel userInfo;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMine) _buildAvatar(screenWidth, screenHeight),
        Container(
          margin: EdgeInsets.only(
            left: screenWidth * 0.02,
            right: screenWidth * 0.03,
            bottom: screenHeight * 0.01,
          ),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMine)
                _buildNickName(screenHeight, theme.textTheme.bodyText2),
              _buildTextAndTime(screenWidth, screenHeight, theme),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildNickName(double screenHeight, TextStyle style) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.005),
      child: Text(
        userInfo.nickName,
        style: style,
      ),
    );
  }

  Widget _buildTextAndTime(
      double screenWidth, double screenHeight, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isMine)
          _buildTimeText(message.createdAt.toDate(), theme.textTheme.caption),
        Container(
          decoration: BoxDecoration(
            color: !isMine ? theme.backgroundColor : theme.accentColor,
            borderRadius: BorderRadius.only(
              topLeft: !isMine ? Radius.circular(0) : Radius.circular(12),
              topRight: isMine ? Radius.circular(0) : Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          margin: EdgeInsets.only(
              left: !isMine ? 0 : screenWidth * 0.01,
              right: isMine ? 0 : screenWidth * 0.01),
          width: message.text.length > 14 ? screenWidth * 0.4 : null,
          child: Text(
            message.text,
            style: theme.textTheme.bodyText2,
          ),
        ),
        if (!isMine)
          _buildTimeText(message.createdAt.toDate(), theme.textTheme.caption),
      ],
    );
  }

  Container _buildAvatar(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(left: screenWidth * 0.03),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userInfo.imageUrl),
          ),
        ],
      ),
    );
  }

  _buildTimeText(DateTime dateTime, TextStyle style) {
    return Column(
      children: [
        Text(
          DateFormat.Hm().format(dateTime),
          style: style,
        ),
      ],
    );
  }
}
