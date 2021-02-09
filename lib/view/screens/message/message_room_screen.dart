import 'package:flutter/material.dart';
import 'package:glowing_front/view/widgets/common/indicator/space_indicator.dart';
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
        ThemeData theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.roomName,
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: model.isBusy
                      ? Center(child: SpaceIndicator(color: theme.accentColor))
                      : GestureDetector(
                          onTap: () => model.notifyListeners(),
                          //FocusScope.of(context).unfocus(),
                          child: model.notExistRoom
                              ? Container()
                              : Messages(model.roomId, model.users),
                        ),
                ),
                MessageSendBar(),
              ],
            ),
          ),
        );
      },
    );
  }
}
