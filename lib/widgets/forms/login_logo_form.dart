import 'package:flutter/material.dart';
import 'package:glowing_front/widgets/ui/button/raised_button_accent.dart';
import 'package:glowing_front/widgets/ui/input/text_input_dark_background.dart';

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
  bool _isSubmitted = false;

  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  final Map<String, TextEditingController> _textControllers = {
    'password': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
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
    _controller.dispose();
    super.dispose();
  }

  void _switchAuthMode() {
    if (!_isSignup)
      _controller.forward();
    else
      _controller.reverse();
    setState(() {
      _isSignup = !_isSignup;
      _isSubmitted = false;
    });
    _formKey.currentState.reset();
    FocusScope.of(context).unfocus();
  }

  void _submit() {
    _formKey.currentState.validate();
    setState(() {
      _isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final double screenHeight = media.size.height - media.padding.top;
    final double screenWidth = media.size.width;
    final double textInputHeight = screenHeight * 0.09;
    return Column(
      children: [
        _buildLogo(screenHeight, screenWidth),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Form(
            key: _formKey,
            autovalidateMode: _isSubmitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTextInputDarkBackground(
                    theme,
                    InputKind.Email,
                    height: textInputHeight,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    height: _isSignup ? textInputHeight : 0,
                    curve: Curves.bounceOut,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildTextInputDarkBackground(
                          theme,
                          InputKind.Nickname,
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    height: _isSignup ? textInputHeight : 0,
                    curve: Curves.bounceOut,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildTextInputDarkBackground(
                          theme,
                          InputKind.Password,
                          controller: _textControllers['password'],
                        ),
                      ),
                    ),
                  ),
                  _buildTextInputDarkBackground(
                    theme,
                    _isSignup ? InputKind.PasswordConfirm : InputKind.Password,
                    height: textInputHeight,
                  ),
                  RaisedButtonAccent(
                    text: _isSignup ? '회원가입' : '로그인',
                    onPressed: _submit,
                    margin: const EdgeInsets.only(top: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildBottomHelpContainer(theme),
      ],
    );
  }

  Container _buildLogo(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.3,
      width: screenWidth * 0.7,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/logo.png',
      ),
    );
  }

  TextInputDarkBackground _buildTextInputDarkBackground(
      ThemeData theme, InputKind kind,
      {TextEditingController controller, double height}) {
    return TextInputDarkBackground(
      textColor: Colors.white,
      lineColor: theme.backgroundColor,
      margin: EdgeInsets.only(bottom: 20),
      inputKind: kind,
      controller: controller,
      controllers: _textControllers,
      height: height,
    );
  }

  Container _buildBottomHelpContainer(ThemeData theme) {
    return Container(
      child: Column(
        children: [
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
    );
  }
}
