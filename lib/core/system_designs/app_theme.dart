import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'app_colors.dart';

class AppTheme {
  // =========================
  // LIGHT MATERIAL THEME
  // =========================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        surface: AppColors.lightSurface,
      ),

      scaffoldBackgroundColor: AppColors.lightBg,

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.lightText,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.lightSurface.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // =========================
  // DARK MATERIAL THEME
  // =========================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        surface: AppColors.darkSurface,
      ),

      scaffoldBackgroundColor: AppColors.darkBg,

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.darkText,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.darkSurface.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static GlassThemeData get glassLightTheme {
    return GlassThemeData(
      light: GlassThemeVariant.light,

    );
  }

  static GlassThemeData get glassDarkTheme {
    return GlassThemeData(
      dark: GlassThemeVariant.dark,

    );
  }
}