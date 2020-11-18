import 'package:flutter/material.dart';

enum InputKind {
  Email,
  Password,
}

class TextInputDarkBackground extends StatelessWidget {
  const TextInputDarkBackground({
    @required this.textColor,
    @required this.lineColor,
    @required this.labelText,
    @required this.icon,
    this.bottomPadding,
    this.inputKind,
  });

  final Color textColor;
  final Color lineColor;
  final String labelText;
  final double bottomPadding;
  final IconData icon;
  final InputKind inputKind;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: TextFormField(
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: textColor),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
        ),
        obscureText: this.inputKind == InputKind.Password ? true : false,
      ),
    );
  }
}
