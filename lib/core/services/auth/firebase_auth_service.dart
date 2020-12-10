import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowing_front/core/models/user_model.dart';
import 'package:glowing_front/core/services/firestore/user_service.dart';

import '../../../locator.dart';
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

  Future<void> signup(String email, String password, String nickName) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await getIt<UserService>().addUser(
        UserModel(
          id: userCredential.user.uid,
          email: email,
          nickName: nickName,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThLP6xJXBY_W2tT5waakogfnpHk4uhpVTy7A&usqp=CAU',
          createdAt: Timestamp.now(),
        ),
      );
    } catch (e) {
      throw AuthException(message: e.message);
    }
  }
}
