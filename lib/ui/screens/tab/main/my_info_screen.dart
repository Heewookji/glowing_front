import 'package:flutter/material.dart';
import 'package:glowing_front/core/providers/auth.dart';
import 'package:provider/provider.dart';

class MyInfoScreen extends StatelessWidget {
  static const routeName = '/myInfo';

  @override
  Widget build(BuildContext context) {
    Auth _auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: ElevatedButton(
              child: Text('logout'),
              onPressed: () => _auth.logOut(),
            ),
          ),
        ],
      )),
    );
  }
}
