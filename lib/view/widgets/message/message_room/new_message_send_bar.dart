import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/message_room_model.dart';
import '../../../../core/services/firestore/message_room_service.dart';
import '../../../../locator.dart';

class NewMessage extends StatefulWidget {
  final String myId;
  final String myImageUrl;
  final String myNickName;

  const NewMessage({
    @required this.myId,
    @required this.myNickName,
    @required this.myImageUrl,
  });

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() {
    if (_enteredMessage.trim().isEmpty) return;
    String message = _enteredMessage;
    setState(() {
      _enteredMessage = '';
    });
    _controller.clear();
    getIt<MessageRoomService>().addMessage(
      MessageModel(
        userId: widget.myId,
        userNickName: widget.myNickName,
        userImageUrl: widget.myImageUrl,
        text: message,
        createdAt: Timestamp.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    labelText: '메시지 보내기'),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
