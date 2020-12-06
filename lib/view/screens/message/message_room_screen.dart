import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/message/message_room/message_send_bar.dart';
import '../../widgets/message/message_room/messages.dart';
import 'message_room_screen_view_model.dart';

class MessageRoomScreen extends StatelessWidget {
  static const routeName = '/message';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageRoomScreenViewModel>.reactive(
      viewModelBuilder: () =>
          MessageRoomScreenViewModel(ModalRoute.of(context).settings.arguments),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.roomName),
          ),
          body: !model.dataReady
              ? Container()
              : Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Messages(model.roomId),
                      ),
                      MessageSendBar(model.roomId, model.data),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
