import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:stacked/stacked.dart';

import 'message_send_bar_view_model.dart';

class MessageSendBar extends StatelessWidget {
  final UserModel _user;

  MessageSendBar(this._user);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageSendBarViewModel>.reactive(
      viewModelBuilder: () => MessageSendBarViewModel(_user),
      builder: (ctx, model, child) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: model.controller,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15),
                        labelText: '메시지 보내기'),
                  ),
                ),
                IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.send),
                  onPressed: model.sendMessage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
