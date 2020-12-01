import 'package:flutter/material.dart';
import 'package:glowing_front/providers/firebase_auth_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/chat/messages.dart';
import '../../widgets/chat/new_message_send_bar.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방'),
        actions: [
          IconButton(
            onPressed: () => Provider.of<FirebaseAuthProvider>(context, listen: false).logOut(),
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
