import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../view/screens/message/message_room_screen.dart';
import '../../widgets/common/indicator/space_indicator.dart';
import 'message_room_list_screen_view_model.dart';

class MessageRoomListScreen extends StatelessWidget {
  static const routeName = '/messageRoomList';

  void _navigateMessageRoom(
    BuildContext context,
    String roomId,
    String roomName,
  ) {
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
          body: model.isBusy
              ? Center(
                  child: SpaceIndicator(
                    color: theme.accentColor,
                  ),
                )
              : ListView.builder(
                  itemCount: model.messageRooms.length,
                  itemBuilder: (_, index) {
                    final messageRoom = model.messageRooms[index];
                    final opponent = model.messageRoomOpponent[messageRoom.id];
                    return GestureDetector(
                      onTap: () => _navigateMessageRoom(
                        context,
                        messageRoom.id,
                        opponent.name,
                      ),
                      child: Card(
                        child: _buildRow(
                          opponent,
                          screenSize,
                          model.busy(messageRoom),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildRow(Opponent opponent, Size screenSize, bool opponentIsBusy) {
    return AnimatedContainer(
      height: opponentIsBusy ? 0 : screenSize.height * 0.07,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeOutCirc,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage:
                opponentIsBusy ? null : NetworkImage(opponent.imageUrl),
          ),
          Text(opponentIsBusy ? '' : opponent.name)
        ],
      ),
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
