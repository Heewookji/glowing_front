import 'package:flutter/material.dart';

import 'colors/accent_color_builder.dart';
import 'colors/primary_color_builder.dart';
import 'colors/secondary_color_dark_builder.dart';

class RootThemeBuilder {
  static ThemeData build() {
    return ThemeData(
      primarySwatch: PrimaryColorBuilder.buildMaterial(),
      accentColor: AccentColorBuilder.build(),
      backgroundColor: SecondaryColorDarkBuilder.build(),
    );
  }
}
