// ---------------- app_theme.dart ----------------
import 'package:flutter/material.dart';

/// All colors used across Join Room, Message, Room Preview & Home screens.
class AppColors {
  AppColors._();

  static const background = Color(0xFF0B0B0D);
  static const avatarBg = Color(0xFF1D1D1F);
  static const accent = Color(0xFFC6F135); // lime-green
  static const subtitle = Color(0xFF9A9A9E);

  static const fieldBg = Color(0xFF19191B);
  static const fieldBorder = Color(0xFF2A2A2D);
  static const inputBg = Color(0xFF19191B);

  static const cardBg = Color(0xFF171A26);
  static const receivedBubble = Color(0xFF1E2233);
  static const dateChipBg = Color(0xFF1D1D1F);
  static const divider = Color(0xFF23232A);

  static const timestamp = Color(0xFFB9BDD3);
  static const timestampOnGreen = Color(0xFF1B3B00);

  static const onAccent = Colors.black; // text/icons on lime buttons
  static const textPrimary = Colors.white;
}

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.accent,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.cardBg,
        onPrimary: AppColors.onAccent,
        onSurface: AppColors.textPrimary,
        error: Colors.redAccent,
      ),

      // ---- AppBar ----
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ---- Text ----
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 15),
        bodyMedium: TextStyle(color: AppColors.subtitle, fontSize: 14),
        bodySmall: TextStyle(color: AppColors.subtitle, fontSize: 12),
      ),

      // ---- Buttons ----
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          elevation: 8,
          shadowColor: AppColors.accent.withOpacity(0.5),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.divider),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onAccent,
        elevation: 8,
      ),

      iconTheme: const IconThemeData(color: AppColors.textPrimary),

      // ---- Inputs ----
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBg,
        hintStyle: const TextStyle(color: AppColors.subtitle, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
      ),

      dividerColor: AppColors.divider,
      cardColor: AppColors.cardBg,
      splashColor: AppColors.accent.withOpacity(0.1),
      highlightColor: Colors.transparent,
    );
  }
}