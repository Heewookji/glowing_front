import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowing_front/locator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../core/models/user_model.dart';
import '../../../core/providers/auth.dart';
import '../../../core/viewmodels/user_crud_model.dart';
import '../../widgets/auth/logo_auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  Future<void> _submitAuthForm(
    String email,
    String password,
    String nickname,
    bool isSignup,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isSignup) {
        final userCredential = await Provider.of<Auth>(context, listen: false)
            .signup(email, password, nickname);
        await getIt<UserCRUDModel>().addUser(
         UserModel(
            id: userCredential.user.uid,
            email: email,
            nickName: nickname,
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/glowing-f88cb.appspot.com/o/%E1%84%80%E1%85%A1%E1%86%AB%E1%84%83%E1%85%A1%E1%86%AF%E1%84%91%E1%85%B3.jpeg?alt=media&token=4d6ab49a-4124-4a4f-9d52-08bf0a082dd5',
            createdAt: Timestamp.now(),
          ),
        );
      } else {
        await Provider.of<Auth>(context, listen: false).login(email, password);
      }
    } catch (e) {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData media = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: _backgroundDecorationBuild(theme),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: media.size.height,
              child: Stack(
                children: [
                  Lottie.asset('assets/animations/ani.json', fit: BoxFit.cover),
                  LogoAuthForm(_submitAuthForm, _isLoading),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _backgroundDecorationBuild(ThemeData theme) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment(0, -2),
        colors: [
          theme.primaryColor,
          Colors.black,
        ],
        stops: [0, 1],
      ),
    );
  }
}
