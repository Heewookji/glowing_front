import 'package:flutter/material.dart';
import 'package:glowing_front/widgets/ui/button/raised_button_accent.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/ui/input/text_input_dark_background.dart';

class LoginScreen extends StatelessWidget {
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
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: screenWidth * 0.6,
                      ),
                    ),
                  ],
                ),
              ),
              LoginForm(),
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

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isSignup = false;

  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
        reverseCurve: Curves.bounceOut,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      _isSignup = !_isSignup;
    });
    _formKey.currentState.reset();
    if (_isSignup)
      _controller.forward();
    else
      _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextInputDarkBackground(
              textColor: Colors.white,
              lineColor: theme.backgroundColor,
              labelText: '이메일',
              icon: Icons.mail_outline_outlined,
              bottomPadding: 20,
              inputKind: InputKind.Email,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              height: _isSignup ? 70 : 0,
              curve: Curves.bounceOut,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: TextInputDarkBackground(
                    textColor: Colors.white,
                    lineColor: theme.backgroundColor,
                    labelText: '닉네임',
                    icon: Icons.person_outline,
                    bottomPadding: 20,
                    inputKind: InputKind.Nickname,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              height: _isSignup ? 70 : 0,
              curve: Curves.bounceOut,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: TextInputDarkBackground(
                    textColor: Colors.white,
                    lineColor: theme.backgroundColor,
                    labelText: '비밀번호',
                    icon: Icons.lock_outline,
                    bottomPadding: 20,
                    inputKind: InputKind.Password,
                  ),
                ),
              ),
            ),
            TextInputDarkBackground(
              textColor: Colors.white,
              lineColor: theme.backgroundColor,
              labelText: _isSignup ? '비밀번호 확인' : '비밀번호',
              icon: Icons.lock_outline,
              bottomPadding: 40,
              inputKind: InputKind.Password,
            ),
            RaisedButtonAccent(text: _isSignup ? '회원가입' : '로그인'),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                '비밀번호를 잊으셨나요?',
                style: TextStyle(color: theme.accentColor),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSignup ? '계정이 있으신가요?' : '계정이 없으신가요?',
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                  padding: EdgeInsets.only(),
                  child: Text(
                    _isSignup ? '로그인' : '회원가입',
                    style: TextStyle(color: theme.accentColor),
                  ),
                  onPressed: _switchAuthMode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
