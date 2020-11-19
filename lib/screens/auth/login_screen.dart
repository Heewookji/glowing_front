import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/forms/login_logo_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData media = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: _backgroundDecorationBuild(theme),
          alignment: Alignment.center,
          height: media.size.height,
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Lottie.asset('assets/animations/ani.json', fit: BoxFit.cover),
                LoginForm(),
              ],
            ),
          ),
        ),
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
      ),
    );
  }
}
