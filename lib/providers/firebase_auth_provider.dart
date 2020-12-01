import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/exceptions/auth_exception.dart';

class FirebaseAuthProvider with ChangeNotifier {
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

  Future<void> signup(String email, String password, String nickname) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user.uid)
          .set({
        'userName': nickname,
        'email': email,
      });
    } catch (e) {
      throw AuthException(message: e.message);
    }
  }
}
