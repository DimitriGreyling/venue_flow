import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  static TextTheme get textTheme => const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 40 / 32,
      letterSpacing: -0.64,
      color: AppColors.textMain,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 32 / 24,
      letterSpacing: -0.24,
      color: AppColors.textMain,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 28 / 20,
      color: AppColors.textMain,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
      color: AppColors.textMain,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 20 / 14,
      color: AppColors.textMain,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
      color: AppColors.textMain,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 16 / 12,
      letterSpacing: 0.6,
      color: AppColors.textMuted,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 14 / 11,
      color: AppColors.textMuted,
    ),
  );
}