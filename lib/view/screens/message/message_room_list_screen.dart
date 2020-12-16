import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/view/widgets/message/message_room_list/message_room_create.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../view/screens/message/message_room_screen.dart';
import '../../widgets/common/indicator/space_indicator.dart';
import 'message_room_list_screen_view_model.dart';

class MessageRoomListScreen extends StatelessWidget {
  static const routeName = '/messageRoomList';

  void _navigateMessageRoom(
    BuildContext context,
    MessageRoomListScreenViewModel model,
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
                    builder: (_) =>
                        MessageRoomCreate(model.messageRoomOpponents),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {},
          ),
          body: model.isBusy
              ? Center(
                  child: SpaceIndicator(
                    color: theme.accentColor,
                  ),
                )
              : ListView.builder(
                  itemCount: model.data.length,
                  itemBuilder: (_, index) {
                    final messageRoom = model.data[index];
                    final opponent = model.messageRoomOpponents[messageRoom.id];
                    final isUnread = model.messageRoomUnread[messageRoom.id];
                    if (model.busy(messageRoom)) return Container();
                    return GestureDetector(
                      onTap: () => _navigateMessageRoom(
                        context,
                        model,
                        messageRoom.id,
                        opponent.nickName,
                      ),
                      child: _buildRow(
                          messageRoom, opponent, isUnread, screenSize, theme),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildRow(MessageRoomModel messageRoom, UserModel opponent,
      bool isUnread, Size screenSize, ThemeData theme) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              maxRadius: screenSize.height * 0.03,
              backgroundImage: NetworkImage(opponent.imageUrl),
              backgroundColor: Colors.transparent,
            ),
            _buildNickNameAndText(opponent, theme, screenSize, messageRoom),
            _buildTimeAndBadge(messageRoom, screenSize, isUnread, theme),
          ],
        ),
      ),
    );
  }

  Column _buildNickNameAndText(UserModel opponent, ThemeData theme,
      Size screenSize, MessageRoomModel messageRoom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          opponent.nickName,
          style: theme.textTheme.bodyText1,
        ),
        Container(
          padding: EdgeInsets.only(top: screenSize.height * 0.005),
          width: screenSize.width * 0.55,
          child: Text(
            messageRoom.lastMessagedText,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Column _buildTimeAndBadge(MessageRoomModel messageRoom, Size screenSize,
      bool isUnread, ThemeData theme) {
    return Column(
      children: [
        Text(DateFormat.Hm().format(messageRoom.lastMessagedAt.toDate())),
        SizedBox(
          height: screenSize.height * 0.03,
          child: isUnread
              ? Icon(Icons.circle, color: theme.accentColor, size: 10)
              : null,
        ),
      ],
    );
  }
}
