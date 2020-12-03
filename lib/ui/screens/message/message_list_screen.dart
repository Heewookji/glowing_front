import 'package:flutter/material.dart';
import 'package:glowing_front/ui/screens/message/message_screen.dart';

class MessageListScreen extends StatelessWidget {
  static const routeName = '/messageList';

  final _textController = TextEditingController();

  void _addNewMessage(ctx, ThemeData theme, Size screenSize) {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx) => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.white,
          height: screenSize.height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                width: screenSize.width * 0.55,
                child: TextFormField(
                  controller: _textController,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                child: FlatButton(
                  onPressed: () {
                    print(_textController.text);
                    Navigator.of(ctx)
                        .pushReplacementNamed(MessageScreen.routeName);
                  },
                  child: Text('채팅시작'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addNewMessage(context, theme, screenSize),
          )
        ],
      ),
      body: Center(
        child: Text('messageList'),
      ),
    );
  }
}
