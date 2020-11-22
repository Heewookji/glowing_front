import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  bool get isAuth {
    return user != null;
  }
}
