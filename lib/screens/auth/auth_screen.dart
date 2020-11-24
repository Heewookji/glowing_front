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
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isSignup) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
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
