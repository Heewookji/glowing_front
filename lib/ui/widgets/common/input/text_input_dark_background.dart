import 'package:flutter/material.dart';

enum InputKind {
  Email,
  Password,
  PasswordConfirm,
  Nickname,
}

class TextInputDarkBackground extends StatelessWidget {
  const TextInputDarkBackground({
    @required this.textColor,
    @required this.lineColor,
    @required this.inputKind,
    @required this.dependentController,
    @required this.controllers,
    @required this.formData,
    @required this.onValidation,
    this.height,
  });

  final Color textColor;
  final Color lineColor;
  final InputKind inputKind;
  final TextEditingController dependentController;
  final Map<String, TextEditingController> controllers;
  final double height;
  final Map<String, String> formData;
  final bool onValidation;

  @override
  Widget build(BuildContext context) {
    String labelText = '';
    IconData icon;
    TextInputType keyboardType;
    Function validator;
    Function onSaver;
    switch (this.inputKind) {
      case InputKind.Email:
        labelText = '이메일';
        icon = Icons.mail_outline_outlined;
        keyboardType = TextInputType.emailAddress;
        validator = _emailValidator;
        onSaver = _emailSaver;
        break;
      case InputKind.Password:
        labelText = '비밀번호';
        icon = Icons.lock_outline;
        validator = _passwordValidator;
        onSaver = _passwordSaver;
        break;
      case InputKind.PasswordConfirm:
        labelText = '비밀번호 확인';
        icon = Icons.lock_outline;
        validator = _passwordConfirmValidator;
        break;
      case InputKind.Nickname:
        labelText = '닉네임';
        icon = Icons.person_outline;
        keyboardType = TextInputType.text;
        validator = _nicknameValidator;
        onSaver = _nicknameSaver;
        break;
      default:
        labelText = '';
        icon = null;
        keyboardType = null;
    }
    return Container(
      height: height,
      child: TextFormField(
        style: TextStyle(color: textColor),
        keyboardType: keyboardType,
        controller: dependentController,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: lineColor),
          prefixIcon: Icon(
            icon,
            color: lineColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lineColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lineColor,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lineColor,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lineColor,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        obscureText: this.inputKind == InputKind.Password ||
                this.inputKind == InputKind.PasswordConfirm
            ? true
            : false,
        validator: onValidation ? validator : null,
        onSaved: onSaver,
      ),
    );
  }

  String _emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) return '적절하지 않은 이메일주소입니다';
    return null;
  }

  void _emailSaver(String value) {
    formData['email'] = value;
  }

  String _passwordValidator(String value) {
    if (value.isEmpty || value.length < 6) return '패스워드는 6글자 이상입니다';
    return null;
  }

  void _passwordSaver(String value) {
    formData['password'] = value;
  }

  String _passwordConfirmValidator(String value) {
    final String passwordValue = this.controllers['password'].text;
    if (value != passwordValue) return '패스워드가 같지 않습니다';
    if (value.isEmpty && passwordValue.isEmpty) return '패스워드를 입력해주세요';
    return null;
  }

  String _nicknameValidator(String value) {
    if (value.isEmpty || !(3 <= value.length && value.length < 9))
      return '닉네임은 3글자에서 8글자 사이입니다';
    return null;
  }

  void _nicknameSaver(String value) {
    formData['nickname'] = value;
  }
}
