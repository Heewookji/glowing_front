import 'package:flutter/material.dart';

class AccentColorBuilder {
  static const int R = 252, G = 163, B = 17;
  static const double OPACITY = 100;
  static const int HEX = 0xFFFCA311;

  static const Map<int, Color> _colorCodes = {
    50: Color.fromRGBO(R, G, B, .1),
    100: Color.fromRGBO(R, G, B, .2),
    200: Color.fromRGBO(R, G, B, .3),
    300: Color.fromRGBO(R, G, B, .4),
    400: Color.fromRGBO(R, G, B, .5),
    500: Color.fromRGBO(R, G, B, .6),
    600: Color.fromRGBO(R, G, B, .7),
    700: Color.fromRGBO(R, G, B, .8),
    800: Color.fromRGBO(R, G, B, .9),
    900: Color.fromRGBO(R, G, B, 1),
  };

  static Color build() {
    return const Color.fromRGBO(R, G, B, OPACITY);
  }

  static MaterialColor buildMaterial() {
    return MaterialColor(HEX, _colorCodes);
  }
}
