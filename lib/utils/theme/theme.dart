import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Color(0xFF1F1F1F),
  scaffoldBackgroundColor: Color(0xFF1F1F1F),
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF262626),
  accentColor: Colors.teal,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  accentColor: Colors.teal,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.white54,
);
