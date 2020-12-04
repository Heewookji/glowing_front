import 'package:flutter/material.dart';

class SpaceIndicator extends StatelessWidget {
  const SpaceIndicator({@required this.color, this.height = 20});
  final Color color;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 2.5,
      ),
    );
  }
}
