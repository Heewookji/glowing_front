import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'screens/group/group_overview_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GroupOverviewScreen.routeName:
        return MaterialPageRoute(builder: (_) => GroupOverviewScreen());
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
