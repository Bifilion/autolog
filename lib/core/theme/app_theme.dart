import 'package:flutter/material.dart';

class AppTheme {
  // Barvy aplikace
  static const Color background = Color(0xFFE7E8F5);
  static const Color surface = Color(0xFFF5F6FB);

  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryDark = Color(0xFF5E4FE0);

  static const Color textPrimary = Color(0xFF2D2A45);
  static const Color textSecondary = Color(0xFF8A8AA3);

  static const Color success = Color(0xFF3FCB8C);
  static const Color danger = Color(0xFFE85C5C);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor: background,

    colorScheme: const ColorScheme.light(
      primary: primary,

      secondary: primaryDark,

      surface: surface,

      error: danger,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: false,

      backgroundColor: background,

      foregroundColor: textPrimary,

      elevation: 0,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimary),

      bodyMedium: TextStyle(color: textPrimary),

      titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),

      titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),

      labelMedium: TextStyle(color: textSecondary),
    ),

    cardTheme: CardThemeData(
      color: surface,

      elevation: 0,

      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,

        foregroundColor: Colors.white,

        elevation: 0,

        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primary,

        foregroundColor: Colors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor: surface,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),

        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),

        borderSide: const BorderSide(color: primary, width: 2),
      ),
    ),

    iconTheme: const IconThemeData(color: primary),

    dividerTheme: const DividerThemeData(color: Color(0xFFE0E1EC)),
  );
}
