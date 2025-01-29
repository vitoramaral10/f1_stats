import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Color(0xFFD70000);

  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    useMaterial3: true,
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}
