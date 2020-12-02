import 'package:flutter/material.dart';
import 'package:glowing_front/core/viewmodels/user_crud_model.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth.dart';
import '../../widgets/chat/messages.dart';
import '../../widgets/chat/new_message_send_bar.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    String userId = auth.user.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방'),
        actions: [
          IconButton(
            onPressed: () => auth.logOut(),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<UserCRUDModel>(context, listen: false)
            .getUserById(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container();
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Messages(),
                ),
                NewMessage(
                  myId: userId,
                  myNickName: snapshot.data.nickName,
                  myImageUrl: snapshot.data.imageUrl,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
