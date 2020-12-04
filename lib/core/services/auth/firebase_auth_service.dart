import 'package:firebase_auth/firebase_auth.dart';

import '../../exceptions/auth_exception.dart';

class FirebaseAuthService {
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

  Future<UserCredential> signup(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw AuthException(message: e.message);
    }
  }
}
