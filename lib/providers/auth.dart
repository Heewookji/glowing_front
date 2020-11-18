import 'dart:async';

import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userEmail;
  Timer _timer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate == null || DateTime.now().isAfter(_expiryDate)) return null;
    return _token;
  }

  String get userEmail {
    return _userEmail;
  }
}
