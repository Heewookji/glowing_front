import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';

import '../../../../locator.dart';

class MessageViewModel extends ChangeNotifier {

  final User auth = getIt<FirebaseAuthService>().user;

}
