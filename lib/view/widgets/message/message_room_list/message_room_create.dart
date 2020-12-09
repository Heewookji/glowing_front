import 'package:flutter/material.dart';
import 'package:glowing_front/view/screens/message/message_room_screen.dart';
import 'package:glowing_front/view/widgets/message/message_room_list/message_room_create_view_model.dart';
import 'package:stacked/stacked.dart';

class MessageRoomCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageRoomCreateViewModel>.reactive(
      viewModelBuilder: () => MessageRoomCreateViewModel(),
      builder: (ctx, model, child) {
        Size screenSize = MediaQuery.of(ctx).size;
        return ClipRRect(
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
                    controller: model.emailController,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(ctx)
                          .pushReplacementNamed(MessageRoomScreen.routeName,arguments: {
                            'roomName': '',
                          });
                    },
                    child: Text('채팅시작'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
