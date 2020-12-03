import 'package:flutter/material.dart';

class MessageListScreen extends StatelessWidget {
  static const routeName = '/messageList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('messageList'),
      ),
    );
  }
}
