import 'package:flutter/material.dart';
import 'package:glowing_front/widgets/ui/button/raised_button_accent.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/ui/input/text_input_dark_background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData media = MediaQuery.of(context);
    final double screenHeight = media.size.height - media.padding.top;
    final double screenWidth = media.size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: _backgroundDecorationBuild(theme),
          alignment: Alignment.center,
          height: media.size.height,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.45,
                child: Stack(
                  children: [
                    Lottie.asset('assets/animations/ani.json',
                        fit: BoxFit.cover),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextInputDarkBackground(
                        textColor: Colors.white,
                        lineColor: theme.backgroundColor,
                        labelText: '이메일',
                        icon: Icons.mail_outline_outlined,
                        bottomPadding: 20,
                      ),
                      TextInputDarkBackground(
                        textColor: Colors.white,
                        lineColor: theme.backgroundColor,
                        labelText: '비밀번호',
                        icon: Icons.lock_outline,
                        bottomPadding: 40,
                        inputKind: InputKind.Password,
                      ),
                      RaisedButtonAccent(text: '로그인'),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          '비밀번호를 잊으셨나요?',
                          style: TextStyle(color: theme.accentColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '계정이 없으신가요?',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 12),
                            Text(
                              '회원가입',
                              style: TextStyle(color: theme.accentColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
