import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/auth/firebase_auth_service.dart';
import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';
import '../../widgets/message/message_room/messages.dart';
import '../../widgets/message/message_room/new_message_send_bar.dart';

class MessageRoomScreen extends StatefulWidget {
  static const routeName = '/message';
  @override
  _MessageRoomScreenState createState() => _MessageRoomScreenState();
}

class _MessageRoomScreenState extends State<MessageRoomScreen> {
  bool _isInit = true;
  Future _userFuture;
  FirebaseAuthService _auth;
  Map<String, String> _arguments;
  String _roomId;
  String _roomName;

  @override
  void didChangeDependencies() {
    if (!_isInit) return;
    super.didChangeDependencies();
    _auth = getIt<FirebaseAuthService>();
    _userFuture = getIt<UserService>().getUserById(_auth.user.uid);
    _arguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _roomId = _arguments['roomId'];
    _roomName = _arguments['roomName'];
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_roomName),
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
