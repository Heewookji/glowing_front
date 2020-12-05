import 'package:flutter/material.dart';

import 'colors/accent_color_builder.dart';
import 'colors/error_color_builder.dart';
import 'colors/primary_color_builder.dart';
import 'colors/secondary_color_dark_builder.dart';

class RootThemeBuilder {
  static ThemeData build() {
    return ThemeData(
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: PrimaryColorBuilder.buildMaterial(),
      accentColor: AccentColorBuilder.build(),
      backgroundColor: SecondaryColorDarkBuilder.build(),
      errorColor: ErrorColorBuilder.build(),
    );
  }
}
