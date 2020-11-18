import 'package:flutter/material.dart';
import 'package:glowing_front/themes/colors/accent_color_builder.dart';
import 'package:glowing_front/themes/colors/primary_color_builder.dart';

class RootThemeBuilder {
  static ThemeData build() {
    return ThemeData(
      primarySwatch: PrimaryColorBuilder.buildMaterial(),
      accentColor: AccentColorBuilder.build(),
    );
  }
}
