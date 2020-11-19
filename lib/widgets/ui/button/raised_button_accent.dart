import 'package:flutter/material.dart';

class RaisedButtonAccent extends StatelessWidget {
  const RaisedButtonAccent({
    @required this.text,
    @required this.onPressed,
    this.margin,
  });

  final String text;
  final Function onPressed;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(color: theme.primaryColor),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: theme.accentColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.black,
          elevation: 10,
        ),
      ),
    );
  }
}
