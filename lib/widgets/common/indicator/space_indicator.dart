import 'package:flutter/material.dart';

class SpaceIndicator extends StatelessWidget {
  const SpaceIndicator({this.height, this.color});
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.4,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 2.5,
      ),
    );
  }
}
