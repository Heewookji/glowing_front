import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glowing_front/ui/screens/message/message_list_screen.dart';
import 'package:glowing_front/ui/screens/message/message_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MessageScreen.routeName:
        return MaterialPageRoute(builder: (_) => MessageScreen());
          case MessageListScreen.routeName:
        return MaterialPageRoute(builder: (_) => MessageListScreen());
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
