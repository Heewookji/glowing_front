import 'package:flutter/material.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';

import '../../../../locator.dart';

class MyInfoScreen extends StatelessWidget {
  static const routeName = '/myInfo';

  @override
  Widget build(BuildContext context) {
    FirebaseAuthService _auth = getIt<FirebaseAuthService>();
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
