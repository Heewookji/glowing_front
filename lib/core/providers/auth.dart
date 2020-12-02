import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User get user => _auth.currentUser;

  Stream<User> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw AuthException(message: e.message);
    }
  }

  void logOut() {
    _auth.signOut();
  }

  Future<UserCredential> signup(
      String email, String password, String nickname) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw AuthException(message: e.message);
    }
  }
}
