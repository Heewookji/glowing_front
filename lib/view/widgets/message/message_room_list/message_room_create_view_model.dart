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
  final Map<String, UserModel> existOpponents;
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';
  bool isValidEmail = false;
  MessageRoomCreateViewModel(this.existOpponents);

  Future<UserModel> findUser() async {
    UserModel user;
    if (emailController.text == auth.email) {
      errorMessage = '자기 자신과는 채팅할 수 없습니다';
      setError(true);
      return user;
    }
    try {
      setBusy(true);
      user = await getIt<UserService>().getUserByEmail(emailController.text);
      clearErrors();
    } on UserException catch (e) {
      errorMessage = e.message;
      setError(true);
      setBusy(false);
    }
    setBusy(false);
    return user;
  }

  MapEntry<String, UserModel> findExistOpponent() {
    for (final opponent in existOpponents.entries)
      if (emailController.text == opponent.value.email) return opponent;
    return null;
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
