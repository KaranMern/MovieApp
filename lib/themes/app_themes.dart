import 'package:flutter/material.dart';

/// Central theme definitions: light and dark [ThemeData] with custom
/// [ColorScheme] and [TextTheme] for consistent branding.
class AppThemes {
  // Light theme colors
  static const Color lightPrimary = Colors.black87;
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightAppBarTitle = Colors.black87;
  static const Color lightAppBarHeader = Colors.black87;

  // Dark theme colors
  static const Color darkPrimary = Color(0xFF90CAF9);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkText = Colors.white;
  static const Color darkAppBarTitle = Color(0xFF90CAF9);
  static const Color darkAppBarHeader = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: Colors.blueAccent,
      onSecondary: Colors.white,
      tertiary: lightBackground,
      surfaceContainer: lightText,
      onSurface: lightText,
      error: Colors.red,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: lightText),
      bodySmall: TextStyle(fontSize: 14, color: lightText),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: lightAppBarTitle,
      ),
      labelMedium: TextStyle(fontSize: 14, color: lightText),
      labelSmall: TextStyle(fontSize: 12, color: lightText),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      onPrimary: Colors.white,
      secondary: Colors.lightBlueAccent,
      tertiary: darkBackground,
      surfaceContainer: darkText,
      surface: Color(0xFF1E1E1E),
      error: Colors.red,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: darkText),
      bodySmall: TextStyle(fontSize: 14, color: darkText),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: darkPrimary,
      ),
      labelMedium: TextStyle(fontSize: 14, color: darkText),
      labelSmall: TextStyle(fontSize: 12, color: darkText),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
