import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/view/screens/message/message_room_list_screen_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/user_model.dart';
import '../../../view/screens/message/message_room_screen.dart';
import '../../../view/widgets/common/indicator/space_indicator.dart';

class MessageRoomListScreen extends StatefulWidget {
  static const routeName = '/messageRoomList';

  @override
  _MessageRoomListScreenState createState() => _MessageRoomListScreenState();
}

class _MessageRoomListScreenState extends State<MessageRoomListScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return ViewModelBuilder<MessageRoomListScreenViewModel>.reactive(
      viewModelBuilder: () => MessageRoomListScreenViewModel(),
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _addNewMessage(context, theme, screenSize),
              )
            ],
          ),
          body: StreamBuilder(
            stream: model.userMessageRoomStream,
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: SpaceIndicator(color: theme.accentColor));
              final messageRooms = snapshot.data.docs
                  .map(
                      (doc) => UserMessageRoomModel.fromMap(doc.data(), doc.id))
                  .toList();
              return ListView.builder(
                itemCount: messageRooms.length,
                itemBuilder: (_, index) {
                  final messageRoom = messageRooms[index];
                  final users = messageRoom.users;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        MessageRoomScreen.routeName,
                        arguments: {
                          'roomId': messageRoom.roomId,
                          'roomName': messageRoom.name,
                        },
                      );
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(messageRoom.name),
                            Text(
                                messageRoom.lastMessagedAt.toDate().toString()),
                            for (int i = 0; i < users.length; i++)
                              Text(users[i].nickName),
                            Text(users.length.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

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
                    //controller: _textController,
                    ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(ctx)
                        .pushReplacementNamed(MessageRoomScreen.routeName);
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
}
