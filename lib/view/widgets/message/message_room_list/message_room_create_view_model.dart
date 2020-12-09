import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/exceptions/user_exception.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/firestore/user_service.dart';
import '../../../../locator.dart';

class MessageRoomCreateViewModel extends BaseViewModel {
  final User auth = getIt<FirebaseAuthService>().user;
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';
  bool isValidEmail = false;
  String existRoomId;
  UserModel existOpponent;

  final Map<String, UserModel> existOpponents;
  MessageRoomCreateViewModel(this.existOpponents);

  bool isExistOpponent() {
    for (final opponent in existOpponents.entries)
      if (emailController.text == opponent.value.email) {
        existRoomId = opponent.key;
        existOpponent = opponent.value;
        return true;
      }
    return false;
  }

  Future<UserModel> findOpponentUser(ctx) async {
    UserModel user;
    try {
      user = await getIt<UserService>().getUserByEmail(emailController.text);
      clearErrors();
    } on UserException catch (e) {
      errorMessage = e.message;
      setError(true);
      notifyListeners();
    }
    return user;
  }

  void validateEmail(String value) {
    errorMessage = '';
    if (emailController.text.isEmpty)
      isValidEmail = false;
    else
      isValidEmail = true;
    notifyListeners();
  }
}
