import 'package:flutter/material.dart';

class AppTheme {
  static get mainTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      );

  static get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      );
}
