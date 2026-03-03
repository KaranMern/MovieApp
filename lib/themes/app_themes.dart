import 'package:flutter/material.dart';

class AppThemes {
  static const Color lightPrimary = Colors.black87;
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF1A1A1A);

  static const Color darkPrimary = Color(0xFF90CAF9);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkText = Color(0xFFFFFFFF);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: lightPrimary,
      onPrimary: Colors.white,
      secondary: Colors.blueAccent,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: lightBackground,
      onBackground: lightText,
      surface: Colors.white,
      onSurface: lightText,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: darkPrimary,
      onPrimary: Colors.black,
      secondary: Colors.lightBlueAccent,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.black,
      background: darkBackground,
      onBackground: darkText,
      surface: Color(0xFF1E1E1E),
      onSurface: darkText,
    ),
  );
}
