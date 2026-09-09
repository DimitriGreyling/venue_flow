import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme buildTextTheme() {
    final inter = GoogleFonts.interTextTheme();
    final plusJakarta = GoogleFonts.plusJakartaSansTextTheme();

    return inter.copyWith(
      displayLarge: plusJakarta.displayLarge,
      displayMedium: plusJakarta.displayMedium,
      displaySmall: plusJakarta.displaySmall,
      headlineLarge: plusJakarta.headlineLarge,
      headlineMedium: plusJakarta.headlineMedium,
      headlineSmall: plusJakarta.headlineSmall,
      titleLarge: plusJakarta.titleLarge,
      titleMedium: plusJakarta.titleMedium,
      titleSmall: plusJakarta.titleSmall,
      bodyLarge: inter.bodyLarge,
      bodyMedium: inter.bodyMedium,
      bodySmall: inter.bodySmall,
      labelLarge: inter.labelLarge,
      labelMedium: inter.labelMedium,
      labelSmall: inter.labelSmall,
    );
  }
}
