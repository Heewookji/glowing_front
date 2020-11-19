import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<void> login(String email, String password) async {
    final String url = '';
    await http.get(url);
  }

  Future<void> signup(String email, String password, String nickname) async {
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';
    await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
  }
}
