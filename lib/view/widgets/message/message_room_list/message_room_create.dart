import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/models/user_model.dart';
import '../../../screens/message/message_room_screen.dart';
import 'message_room_create_view_model.dart';

class MessageRoomCreate extends StatelessWidget {
  final Map<String, UserModel> existOpponents;
  MessageRoomCreate(this.existOpponents);

  void goMessageRoom(ctx, MessageRoomCreateViewModel model) async {
    Map<String, Object> arguments;
    if (model.isExistOpponent()) {
      arguments = {
        'roomId': model.existRoomId,
        'roomName': model.existOpponent.nickName
      };
    } else {
      // 새로운 1대 1 채팅방을 만들 경우
      final opponentUser = await model.findOpponentUser(ctx);
      if (model.hasError) return;
      arguments = {
        'roomName': opponentUser.nickName,
        'opponentId': opponentUser.id,
      };
    }
    Navigator.of(ctx).pushReplacementNamed(
      MessageRoomScreen.routeName,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageRoomCreateViewModel>.reactive(
      viewModelBuilder: () => MessageRoomCreateViewModel(existOpponents),
      builder: (ctx, model, child) {
        ThemeData theme = Theme.of(context);
        Size screenSize = MediaQuery.of(ctx).size;
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            height: screenSize.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      width: screenSize.width * 0.55,
                      child: TextFormField(
                        controller: model.emailController,
                        onChanged: model.validateEmail,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: FlatButton(
                        onPressed: !model.isValidEmail
                            ? null
                            : () => goMessageRoom(ctx, model),
                        child: Text('채팅시작'),
                      ),
                    ),
                  ],
                ),
                Text(
                  model.errorMessage,
                  style: TextStyle(color: theme.errorColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
