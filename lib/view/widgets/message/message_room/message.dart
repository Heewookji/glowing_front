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
    @required this.isSameMinutes,
    @required this.isMinuteFirst,
  });

  final Key key;
  final bool isMine;
  final UserModel userInfo;
  final MessageModel message;
  final bool isSameMinutes;
  final bool isMinuteFirst;

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
        Container(
          width: screenWidth * 0.1,
          margin: EdgeInsets.only(left: screenWidth * 0.03),
          child: isMinuteFirst && !isMine
              ? _buildAvatar(screenWidth, screenHeight)
              : null,
        ),
        Container(
          margin: EdgeInsets.only(
            left: screenWidth * 0.02,
            right: screenWidth * 0.03,
            bottom: screenHeight * 0.008,
          ),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (isMinuteFirst && !isMine)
                _buildNickName(screenHeight, theme.textTheme.bodyText2),
              _buildTextAndTime(screenWidth, screenHeight, theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNickName(double screenHeight, TextStyle style) {
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
        if (!isSameMinutes && isMine)
          _buildTimeText(message.createdAt, theme.textTheme.caption),
        _buildMessageBubble(theme, screenWidth),
        if (!isSameMinutes && !isMine)
          _buildTimeText(message.createdAt, theme.textTheme.caption),
      ],
    );
  }

  Widget _buildMessageBubble(ThemeData theme, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: !isMine ? theme.backgroundColor : theme.accentColor,
        borderRadius: BorderRadius.only(
          topLeft: isMinuteFirst && !isMine
              ? Radius.circular(0)
              : Radius.circular(12),
          topRight: isMinuteFirst && isMine
              ? Radius.circular(0)
              : Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      margin: EdgeInsets.only(
          left: !isMine ? 0 : screenWidth * 0.01,
          right: isMine ? 0 : screenWidth * 0.01),
      width: message.text.length > 14 ? screenWidth * 0.4 : null,
      child: Text(
        message.text,
        style: theme.textTheme.bodyText2,
      ),
    );
  }

  Widget _buildAvatar(double screenWidth, double screenHeight) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userInfo.imageUrl),
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildTimeText(DateTime dateTime, TextStyle style) {
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
