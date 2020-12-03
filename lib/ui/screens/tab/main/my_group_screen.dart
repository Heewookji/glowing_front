import 'package:flutter/material.dart';

class MyGroupScreen extends StatelessWidget {
  static const routeName = '/myGroup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text('myGroup screen'),
          ),
        ],
      )),
    );
  }
}
