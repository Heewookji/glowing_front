import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/forms/logo_auth_form.dart';

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
  ) async {
    setState(() {
      _isLoading = true;
    });
    if (isSignup) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password')
          print('The password provided is too weak.');
        else if (e.code == 'email-already-in-use')
          print('The account already exists for that email.');
        else
          print(e);
      } catch (e) {
        print(e);
      }
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found')
          print('No user found for that email.');
        else if (e.code == 'wrong-password')
          print('Wrong password provided for that user.');
        else
          print(e);
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      _isLoading = false;
    });
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
    ));
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
