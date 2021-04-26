import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.teal,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.teal,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.white54,
);
