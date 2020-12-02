import 'package:flutter/material.dart';

class GroupOverviewScreen extends StatelessWidget {
  static const routeName = '/groups';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text('group list'),
          ),
        ],
      )),
    );
  }
}
