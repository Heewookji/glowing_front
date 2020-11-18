import 'package:flutter/material.dart';
import 'package:glowing_front/themes/root_theme_builder.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glowing',
      theme: RootThemeBuilder.build(),
      home: HomeScreen(),
    );
  }
}

