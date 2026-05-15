import 'package:flutter/material.dart';
import 'app_text_style.dart';
import 'app_colors.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      scaffoldBackgroundColor: AppColors.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0.5,
        centerTitle: true,
        titleTextStyle: AppTextStyle.h3.copyWith(color: AppColors.textPrimary),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.r16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          textStyle: AppTextStyle.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: AppColors.primary,
      scaffoldBackgroundColor: Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyle.h3.copyWith(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: Color(0xFF1E1E1E),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.r16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          textStyle: AppTextStyle.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: Color(0xFF333333)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: const BorderSide(color: Color(0xFF333333)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}


