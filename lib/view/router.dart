import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glowing_front/view/screens/message/message_room_list_screen.dart';
import 'package:glowing_front/view/screens/message/message_room_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MessageRoomListScreen.routeName:
        return MaterialPageRoute(builder: (_) => MessageRoomListScreen());
      case MessageRoomScreen.routeName:
        return MaterialPageRoute(builder: (_) => MessageRoomScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name}는 잘못된 경로입니다.'),
            ),
          ),
        );
    }
  }
}
