import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupOverviewScreen extends StatelessWidget {
  static const routeName = '/groups';

  void _logout() async {
    await FirebaseAuth.instance.signOut();
  }

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
          RaisedButton(
            onPressed: _logout,
            child: Text('로그아웃'),
          )
        ],
      )),
    );
  }
}
