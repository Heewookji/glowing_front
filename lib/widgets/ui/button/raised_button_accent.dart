import 'package:flutter/material.dart';

class RaisedButtonAccent extends StatelessWidget {
  const RaisedButtonAccent({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: theme.primaryColor),
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: theme.accentColor,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black,
        elevation: 10,
      ),
    );
  }
}
