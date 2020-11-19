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
    @required this.margin,
    @required this.inputKind,
    @required this.controller,
    @required this.controllers,
    this.height,
  });

  final Color textColor;
  final Color lineColor;
  final EdgeInsets margin;
  final InputKind inputKind;
  final TextEditingController controller;
  final Map<String, TextEditingController> controllers;
  final double height;

  @override
  Widget build(BuildContext context) {
    String labelText = '';
    IconData icon;
    TextInputType keyboardType;
    Function validator;
    switch (this.inputKind) {
      case InputKind.Email:
        labelText = '이메일';
        icon = Icons.mail_outline_outlined;
        keyboardType = TextInputType.emailAddress;
        validator = _emailValidator;
        break;
      case InputKind.Password:
        labelText = '비밀번호';
        icon = Icons.lock_outline;
        validator = _passwordValidator;
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
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: textColor),
          errorStyle: TextStyle(color: textColor),
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
        ),
        obscureText: this.inputKind == InputKind.Password ||
                this.inputKind == InputKind.PasswordConfirm
            ? true
            : false,
        validator: validator,
      ),
    );
  }

  String _emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) return '적절하지 않은 이메일주소입니다';
    return null;
  }

  String _passwordValidator(String value) {
    if (value.isEmpty || value.length < 8) return '패스워드는 8글자 이상입니다';
    return null;
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
}
