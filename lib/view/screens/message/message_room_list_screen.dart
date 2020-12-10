import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/view/widgets/message/message_room_list/message_room_create.dart';
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
        Size screenSize = MediaQuery.of(ctx).size;
        ThemeData theme = Theme.of(ctx);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => MessageRoomCreate(model.messageRoomOpponents),
                  );
                },
              ),
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
                    final opponent = model.messageRoomOpponents[messageRoom.id];
                    return GestureDetector(
                      onTap: () => _navigateMessageRoom(
                        context,
                        messageRoom.id,
                        opponent.nickName,
                      ),
                      child: Card(
                        child: _buildRow(
                          opponent,
                          screenSize,
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildRow(UserModel opponent, Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(opponent.imageUrl),
          ),
          Text(opponent.nickName)
        ],
      ),
    );
  }
}
