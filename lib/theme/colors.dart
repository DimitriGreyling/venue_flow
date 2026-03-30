import 'package:flutter/material.dart';

/// The Editorial Concierge Color System
/// Balances warmth of champagne and ivory with the authority of deep slate.
/// Supports both light and dark themes while maintaining the luxury aesthetic.
class EditorialColors {
  EditorialColors._();

  // Core Brand Colors (consistent across themes)
  static const Color deepSlate = Color(0xFF446464);
  static const Color sophisticatedEarth = Color(0xFF685D4A);
  static const Color goldAccent = Color(0xFF735C00);

  // LIGHT THEME COLORS
  // Primary Palette - Deep Slate (#446464)
  static const Color lightPrimary = Color(0xFF446464);
  static const Color lightPrimaryContainer = Color(0xFFC6E9E9);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnPrimaryContainer = Color(0xFF002020);

  // Secondary Palette - Muted earth tone (#685d4a)
  static const Color lightSecondary = Color(0xFF685D4A);
  static const Color lightSecondaryContainer = Color(0xFFEDDEC5);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnSecondaryContainer = Color(0xFF221B0B);

  // Tertiary Palette - Gold accent (#735c00)
  static const Color lightTertiary = Color(0xFF735C00);
  static const Color lightTertiaryContainer = Color(0xFFFFE7A8);
  static const Color lightOnTertiary = Color(0xFFFFFFFF);
  static const Color lightOnTertiaryContainer = Color(0xFF241A00);

  // Surface Hierarchy - "Layered Vellum Paper" System
  static const Color lightSurface = Color(0xFFFAFAEB); // Champagne base
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF); // Interactive cards
  static const Color lightSurfaceContainerLow = Color(0xFFF4F5E6); // Sectioning
  static const Color lightSurfaceContainer = Color(0xFFEFEFE0);
  static const Color lightSurfaceContainerHigh = Color(0xFFE9E9DB);
  static const Color lightSurfaceContainerHighest = Color(0xFFE3E3D5);
  static const Color lightSurfaceDim = Color(0xFFDBDBCD);
  static const Color lightSurfaceBright = Color(0xFFFAFAEB);

  // Text Colors - No 100% black, soft champagne-toned alternatives
  static const Color lightOnSurface = Color(0xFF1B1C14);
  static const Color lightOnSurfaceVariant = Color(0xFF4B463D);

  // DARK THEME COLORS
  // Primary Palette - Inverted Deep Slate, maintaining sophistication
  static const Color darkPrimary = Color(0xFFABCDCD); // Lightened slate
  static const Color darkPrimaryContainer = Color(0xFF2C4C4C); // Darker slate
  static const Color darkOnPrimary = Color(0xFF002020);
  static const Color darkOnPrimaryContainer = Color(0xFFC6E9E9);

  // Secondary Palette - Warm earth tones for dark mode
  static const Color darkSecondary = Color(0xFFCFC5AD); // Lightened earth
  static const Color darkSecondaryContainer = Color(0xFF4F4533); // Darker earth
  static const Color darkOnSecondary = Color(0xFF221B0B);
  static const Color darkOnSecondaryContainer = Color(0xFFEDDEC5);

  // Tertiary Palette - Gold remains prominent in dark mode
  static const Color darkTertiary = Color(0xFFE9C349); // Brightened gold
  static const Color darkTertiaryContainer = Color(0xFF574500); // Darker gold
  static const Color darkOnTertiary = Color(0xFF241A00);
  static const Color darkOnTertiaryContainer = Color(0xFFFFE7A8);

  // Dark Surface Hierarchy - "Midnight Vellum" System
  static const Color darkSurface = Color(0xFF131410); // Deep warm black
  static const Color darkSurfaceContainerLowest = Color(0xFF1E1F18); // Interactive cards
  static const Color darkSurfaceContainerLow = Color(0xFF1B1C14); // Sectioning
  static const Color darkSurfaceContainer = Color(0xFF1F201A);
  static const Color darkSurfaceContainerHigh = Color(0xFF2A2B24);
  static const Color darkSurfaceContainerHighest = Color(0xFF34352E);
  static const Color darkSurfaceDim = Color(0xFF101108);
  static const Color darkSurfaceBright = Color(0xFF35372E);

  // Dark Text Colors - Warm whites that complement the champagne aesthetic
  static const Color darkOnSurface = Color(0xFFE6E6D8);
  static const Color darkOnSurfaceVariant = Color(0xFFC6C2B8);

  // Shared colors across themes
  static const Color error = Color(0xFFBA1A1A);
  static const Color lightErrorContainer = Color(0xFFFFDAD6);
  static const Color darkErrorContainer = Color(0xFF93000A);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color darkOnError = Color(0xFFFFFFFF);
  static const Color lightOnErrorContainer = Color(0xFF410002);
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);

  // Outline colors
  static const Color lightOutline = Color(0xFF7D766C);
  static const Color lightOutlineVariant = Color(0xFFCEC5BA);
  static const Color darkOutline = Color(0xFF968F85);
  static const Color darkOutlineVariant = Color(0xFF4B463D);

  // Inverse colors
  static const Color lightInverseSurface = Color(0xFF2F3128);
  static const Color lightOnInverseSurface = Color(0xFFF1F2E3);
  static const Color lightInversePrimary = Color(0xFFABCDCD);
  static const Color darkInverseSurface = Color(0xFFE6E6D8);
  static const Color darkOnInverseSurface = Color(0xFF2F3128);
  static const Color darkInversePrimary = Color(0xFF446464);

  // Signature gradients for premium feel
  static LinearGradient silkSheen = const LinearGradient(
    begin: Alignment(-1.0, -1.0),
    end: Alignment(0.707, 0.707),
    colors: [lightPrimary, lightPrimaryContainer],
  );

  static LinearGradient darkSilkSheen = const LinearGradient(
    begin: Alignment(-1.0, -1.0),
    end: Alignment(0.707, 0.707),
    colors: [darkPrimary, darkPrimaryContainer],
  );

  // Glassmorphism support
  static Color lightGlassSurface = lightSurface.withOpacity(0.8);
  static Color darkGlassSurface = darkSurface.withOpacity(0.8);

  // Ghost border for subtle dividers (15% opacity)
  static Color lightGhostBorder = lightOutlineVariant.withOpacity(0.15);
  static Color darkGhostBorder = darkOutlineVariant.withOpacity(0.15);

  // Ambient shadow colors
  static Color lightAmbientShadow = lightPrimary.withOpacity(0.04);
  static Color darkAmbientShadow = Colors.black.withOpacity(0.12);
}

/// Light theme ColorScheme for Editorial Concierge
ColorScheme get lightEditorialColorScheme => const ColorScheme(
  brightness: Brightness.light,
  primary: EditorialColors.lightPrimary,
  onPrimary: EditorialColors.lightOnPrimary,
  primaryContainer: EditorialColors.lightPrimaryContainer,
  onPrimaryContainer: EditorialColors.lightOnPrimaryContainer,
  secondary: EditorialColors.lightSecondary,
  onSecondary: EditorialColors.lightOnSecondary,
  secondaryContainer: EditorialColors.lightSecondaryContainer,
  onSecondaryContainer: EditorialColors.lightOnSecondaryContainer,
  tertiary: EditorialColors.lightTertiary,
  onTertiary: EditorialColors.lightOnTertiary,
  tertiaryContainer: EditorialColors.lightTertiaryContainer,
  onTertiaryContainer: EditorialColors.lightOnTertiaryContainer,
  error: EditorialColors.error,
  onError: EditorialColors.lightOnError,
  errorContainer: EditorialColors.lightErrorContainer,
  onErrorContainer: EditorialColors.lightOnErrorContainer,
  surface: EditorialColors.lightSurface,
  onSurface: EditorialColors.lightOnSurface,
  surfaceDim: EditorialColors.lightSurfaceDim,
  surfaceBright: EditorialColors.lightSurfaceBright,
  surfaceContainerLowest: EditorialColors.lightSurfaceContainerLowest,
  surfaceContainerLow: EditorialColors.lightSurfaceContainerLow,
  surfaceContainer: EditorialColors.lightSurfaceContainer,
  surfaceContainerHigh: EditorialColors.lightSurfaceContainerHigh,
  surfaceContainerHighest: EditorialColors.lightSurfaceContainerHighest,
  onSurfaceVariant: EditorialColors.lightOnSurfaceVariant,
  outline: EditorialColors.lightOutline,
  outlineVariant: EditorialColors.lightOutlineVariant,
  shadow: Colors.black,
  scrim: Colors.black,
  inverseSurface: EditorialColors.lightInverseSurface,
  onInverseSurface: EditorialColors.lightOnInverseSurface,
  inversePrimary: EditorialColors.lightInversePrimary,
  surfaceTint: EditorialColors.lightPrimary,
);

/// Dark theme ColorScheme for Editorial Concierge
ColorScheme get darkEditorialColorScheme => const ColorScheme(
  brightness: Brightness.dark,
  primary: EditorialColors.darkPrimary,
  onPrimary: EditorialColors.darkOnPrimary,
  primaryContainer: EditorialColors.darkPrimaryContainer,
  onPrimaryContainer: EditorialColors.darkOnPrimaryContainer,
  secondary: EditorialColors.darkSecondary,
  onSecondary: EditorialColors.darkOnSecondary,
  secondaryContainer: EditorialColors.darkSecondaryContainer,
  onSecondaryContainer: EditorialColors.darkOnSecondaryContainer,
  tertiary: EditorialColors.darkTertiary,
  onTertiary: EditorialColors.darkOnTertiary,
  tertiaryContainer: EditorialColors.darkTertiaryContainer,
  onTertiaryContainer: EditorialColors.darkOnTertiaryContainer,
  error: EditorialColors.error,
  onError: EditorialColors.darkOnError,
  errorContainer: EditorialColors.darkErrorContainer,
  onErrorContainer: EditorialColors.darkOnErrorContainer,
  surface: EditorialColors.darkSurface,
  onSurface: EditorialColors.darkOnSurface,
  surfaceDim: EditorialColors.darkSurfaceDim,
  surfaceBright: EditorialColors.darkSurfaceBright,
  surfaceContainerLowest: EditorialColors.darkSurfaceContainerLowest,
  surfaceContainerLow: EditorialColors.darkSurfaceContainerLow,
  surfaceContainer: EditorialColors.darkSurfaceContainer,
  surfaceContainerHigh: EditorialColors.darkSurfaceContainerHigh,
  surfaceContainerHighest: EditorialColors.darkSurfaceContainerHighest,
  onSurfaceVariant: EditorialColors.darkOnSurfaceVariant,
  outline: EditorialColors.darkOutline,
  outlineVariant: EditorialColors.darkOutlineVariant,
  shadow: Colors.black,
  scrim: Colors.black,
  inverseSurface: EditorialColors.darkInverseSurface,
  onInverseSurface: EditorialColors.darkOnInverseSurface,
  inversePrimary: EditorialColors.darkInversePrimary,
  surfaceTint: EditorialColors.darkPrimary,
);