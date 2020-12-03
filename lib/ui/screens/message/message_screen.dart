import 'package:flutter/material.dart';
import 'package:glowing_front/core/viewmodels/user_crud_model.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth.dart';
import '../../../locator.dart';
import '../../widgets/chat/messages.dart';
import '../../widgets/chat/new_message_send_bar.dart';

class MessageScreen extends StatefulWidget {
  static const routeName = '/message';
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Future _userFuture;
  Auth _auth;

  @override
  void initState() {
    _auth = Provider.of<Auth>(context, listen: false);
    _userFuture = getIt<UserCRUDModel>().getUserById(_auth.user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방'),
        actions: [
          IconButton(
            onPressed: () => _auth.logOut(),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _userFuture,
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
                  myId: _auth.user.uid,
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
