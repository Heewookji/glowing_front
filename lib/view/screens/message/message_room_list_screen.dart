import 'package:flutter/material.dart';
import 'package:glowing_front/view/screens/message/message_room_list_screen_view_model.dart';
import 'package:glowing_front/view/widgets/common/indicator/space_indicator.dart';
import 'package:stacked/stacked.dart';

import '../../../view/screens/message/message_room_screen.dart';

class MessageRoomListScreen extends StatefulWidget {
  static const routeName = '/messageRoomList';

  @override
  _MessageRoomListScreenState createState() => _MessageRoomListScreenState();
}

class _MessageRoomListScreenState extends State<MessageRoomListScreen> {
  void _navigateMessageRoom(String roomId, String roomName) {
    Navigator.of(context).pushNamed(
      MessageRoomScreen.routeName,
      arguments: {
        'roomId': roomId,
        'roomName': roomName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageRoomListScreenViewModel>.reactive(
      viewModelBuilder: () => MessageRoomListScreenViewModel(),
      builder: (ctx, model, child) {
        Size screenSize = MediaQuery.of(context).size;
        ThemeData theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _addNewMessageRoom(
                    context, model.emailController, screenSize),
              )
            ],
          ),
          body: !model.dataReady
              ? Center(
                  child: SpaceIndicator(
                    color: theme.accentColor,
                  ),
                )
              : ListView.builder(
                  itemCount: model.messageRooms.length,
                  itemBuilder: (_, index) {
                    final messageRoom = model.messageRooms[index];
                    final users = messageRoom.users;
                    return GestureDetector(
                      onTap: () => _navigateMessageRoom(
                          messageRoom.roomId, messageRoom.name),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(messageRoom.name),
                              Text(messageRoom.lastMessagedAt
                                  .toDate()
                                  .toString()),
                              for (int i = 0; i < users.length; i++)
                                Text(users[i].nickName),
                              Text(users.length.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  void _addNewMessageRoom(
      ctx, TextEditingController emailController, Size screenSize) {
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
                  controller: emailController,
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
