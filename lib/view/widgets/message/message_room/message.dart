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
      children: [
        if (!isMine) _buildAvatar(screenWidth, screenHeight),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMine) _buildNickName(theme.textTheme.bodyText1),
              _buildTextAndTime(screenWidth, theme),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildNickName(TextStyle style) {
    return Container(
      child: Text(
        userInfo.nickName,
        style: style,
      ),
    );
  }

  Widget _buildTextAndTime(double screenWidth, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5,
        bottom: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMine)
            _buildTimeText(message.createdAt.toDate(), theme.textTheme.caption),
          Container(
            width: screenWidth * 0.35,
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
              horizontal: 16,
            ),
            margin: EdgeInsets.only(
                left: !isMine ? 0 : screenWidth * 0.01,
                right: isMine ? 0 : screenWidth * 0.01),
            child: Text(
              message.text,
              style: TextStyle(
                color: isMine
                    ? Colors.black
                    : theme.accentTextTheme.headline6.color,
              ),
              textAlign: isMine ? TextAlign.end : TextAlign.start,
            ),
          ),
          if (!isMine)
            _buildTimeText(message.createdAt.toDate(), theme.textTheme.caption),
        ],
      ),
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
          SizedBox(
            height: screenHeight * 0.04,
          )
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
