import 'package:flutter/material.dart';

class MyInfoScreen extends StatelessWidget {
  static const routeName = '/myInfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text('myInfo screen'),
          ),
        ],
      )),
    );
  }
}
