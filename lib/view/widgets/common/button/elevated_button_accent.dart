import 'package:flutter/material.dart';

class ElevatedButtonAccent extends StatelessWidget {
  const ElevatedButtonAccent({
    @required this.child,
    @required this.onPressed,
    @required this.height,
    this.margin,
  });

  final Widget child;
  final Function onPressed;
  final EdgeInsets margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      margin: margin,
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: theme.accentColor,
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
