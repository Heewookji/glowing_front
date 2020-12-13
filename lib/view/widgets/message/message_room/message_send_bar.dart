import 'package:flutter/material.dart';
import 'package:glowing_front/view/screens/message/message_room_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class MessageSendBar extends ViewModelWidget<MessageRoomScreenViewModel> {
  @override
  Widget build(BuildContext context, MessageRoomScreenViewModel parentModel) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: parentModel.textSendBarController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    labelText: '메시지 보내기'),
              ),
            ),
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: () => parentModel.sendMessage(),
            ),
          ],
        ),
      ),
    );
  }
}
