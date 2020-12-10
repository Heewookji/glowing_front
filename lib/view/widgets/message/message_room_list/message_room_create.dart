import 'package:flutter/material.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:stacked/stacked.dart';
import '../../../screens/message/message_room_screen.dart';
import 'message_room_create_view_model.dart';

class MessageRoomCreate extends StatelessWidget {
  final Map<String, UserModel> existOpponents;
  MessageRoomCreate(this.existOpponents);

  void goMessageRoom(ctx, MessageRoomCreateViewModel model) async {
    Map<String, Object> arguments;
    final existOpponent = model.findExistOpponent();
    if (existOpponent != null) {
      arguments = {
        'roomId': existOpponent.key,
        'roomName': existOpponent.value.nickName,
      };
    } else {
      // 새로운 1대 1 채팅방을 만들 경우
      final opponentUser = await model.findUser();
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
        return SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: screenSize.height * 0.04,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom +
                      (screenSize.height * 0.04)),
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
          ),
        );
      },
    );
  }
}
