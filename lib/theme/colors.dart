import 'package:flutter/material.dart';

/// The Architectural Flow Color System
/// "Atmospheric Blues" and "Architectural Greens" foundation
/// Implements the "No-Line" rule with tonal depth and layered surfaces
class EditorialColors {
  EditorialColors._();

  // Core Brand Colors - Atmospheric Blues & Architectural Greens
  static const Color atmosphericBlue = Color(0xFF0b1c30);
  static const Color architecturalGreen = Color(0xFF00311f);
  static const Color techBoutique = Color(0xFF4059aa);

  // LIGHT THEME COLORS - Architectural Flow Palette
  // Primary Palette - Architectural Green (#00311f)
  static const Color lightPrimary = Color(0xFF00311f);
  static const Color lightPrimaryContainer = Color(0xFF004a31);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnPrimaryContainer = Color(0xFF27c38a);

  // Secondary Palette - Tech Boutique Blue (#4059aa)
  static const Color lightSecondary = Color(0xFF4059aa);
  static const Color lightSecondaryContainer = Color(0xFF8fa7fe);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnSecondaryContainer = Color(0xFF1d3989);

  // Tertiary Palette - Warm Alert (#4b1c00)
  static const Color lightTertiary = Color(0xFF4b1c00);
  static const Color lightTertiaryContainer = Color(0xFF6e2c00);
  static const Color lightOnTertiary = Color(0xFFFFFFFF);
  static const Color lightOnTertiaryContainer = Color(0xFFf39461);

  // Surface Hierarchy - "The Orchestrated Atmosphere" Tonal Architecture
  static const Color lightBackground = Color(0xFFf8f9ff); // Base Layer - The floor
  static const Color lightSurface = Color(0xFFf8f9ff); // Main Canvas
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF); // Top Layer - High-priority cards
  static const Color lightSurfaceContainerLow = Color(0xFFeff4ff); // Sidebar/Navigation
  static const Color lightSurfaceContainer = Color(0xFFe5eeff); // Mid Layer - Grouping blocks
  static const Color lightSurfaceContainerHigh = Color(0xFFdce9ff); // Active Interaction Areas
  static const Color lightSurfaceContainerHighest = Color(0xFFd3e4fe); // Destructive/Alert backgrounds
  static const Color lightSurfaceDim = Color(0xFFcbdbf5);
  static const Color lightSurfaceBright = Color(0xFFf8f9ff);

  // Text Colors - Atmospheric Blue foundation, no pure black
  static const Color lightOnSurface = Color(0xFF0b1c30); // Deep atmospheric blue
  static const Color lightOnSurfaceVariant = Color(0xFF444651); // Muted secondary labels

  // DARK THEME COLORS - Architectural Flow Palette (Dark Mode)
  // Primary Palette - Architectural Green (lightened for dark mode)
  static const Color darkPrimary = Color(0xFF4edea3); // Lightened architectural green
  static const Color darkPrimaryContainer = Color(0xFF005236); // Darker green container
  static const Color darkOnPrimary = Color(0xFF002113);
  static const Color darkOnPrimaryContainer = Color(0xFF6ffbbe);

  // Secondary Palette - Tech Boutique Blue (adjusted for dark mode)
  static const Color darkSecondary = Color(0xFFb6c4ff); // Lightened blue
  static const Color darkSecondaryContainer = Color(0xFF264191); // Darker blue container
  static const Color darkOnSecondary = Color(0xFF00164e);
  static const Color darkOnSecondaryContainer = Color(0xFFdce1ff);

  // Tertiary Palette - Warm Alert (adjusted for dark mode)
  static const Color darkTertiary = Color(0xFFffb691); // Lightened warm
  static const Color darkTertiaryContainer = Color(0xFF773205); // Darker warm container
  static const Color darkOnTertiary = Color(0xFF341100);
  static const Color darkOnTertiaryContainer = Color(0xFFffdbcb);

  // Dark Surface Hierarchy - "Midnight Architectural" System
  static const Color darkBackground = Color(0xFF0f1419); // Dark atmospheric base
  static const Color darkSurface = Color(0xFF0f1419); // Main dark canvas
  static const Color darkSurfaceContainerLowest = Color(0xFF1a1f25); // Top layer cards
  static const Color darkSurfaceContainerLow = Color(0xFF171c22); // Sidebar/Navigation
  static const Color darkSurfaceContainer = Color(0xFF1e232a); // Mid layer grouping
  static const Color darkSurfaceContainerHigh = Color(0xFF252a31); // Active interactions
  static const Color darkSurfaceContainerHighest = Color(0xFF2c3138); // Alert backgrounds
  static const Color darkSurfaceDim = Color(0xFF0b0f14);
  static const Color darkSurfaceBright = Color(0xFF31363d);

  // Dark Text Colors - Light atmospheric tones
  static const Color darkOnSurface = Color(0xFFeaf1ff); // Light atmospheric blue
  static const Color darkOnSurfaceVariant = Color(0xFFc4c6cf); // Muted light labels

  // Shared colors across themes
  static const Color error = Color(0xFFBA1A1A);
  static const Color lightErrorContainer = Color(0xFFFFDAD6);
  static const Color darkErrorContainer = Color(0xFF93000A);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color darkOnError = Color(0xFFFFFFFF);
  static const Color lightOnErrorContainer = Color(0xFF410002);
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);

  // Outline colors - Atmospheric Blue toned
  static const Color lightOutline = Color(0xFF757682);
  static const Color lightOutlineVariant = Color(0xFFc5c5d3);
  static const Color darkOutline = Color(0xFF968f85);
  static const Color darkOutlineVariant = Color(0xFF4b463d);

  // Inverse colors
  static const Color lightInverseSurface = Color(0xFF2F3128);
  static const Color lightOnInverseSurface = Color(0xFFF1F2E3);
  static const Color lightInversePrimary = Color(0xFFABCDCD);
  static const Color darkInverseSurface = Color(0xFFE6E6D8);
  static const Color darkOnInverseSurface = Color(0xFF2F3128);
  static const Color darkInversePrimary = Color(0xFF446464);

  // Signature gradients - "Glass & Gradient" Rule
  // Primary CTAs use gradient from primary_container to primary at 135 degrees
  static LinearGradient primaryCtaGradient = const LinearGradient(
    begin: Alignment(-0.707, -0.707), // 135 degree angle
    end: Alignment(0.707, 0.707),
    colors: [lightPrimaryContainer, lightPrimary],
  );

  static LinearGradient silkSheen = primaryCtaGradient;

  static LinearGradient darkSilkSheen = const LinearGradient(
    begin: Alignment(-0.707, -0.707),
    end: Alignment(0.707, 0.707),
    colors: [darkPrimaryContainer, darkPrimary],
  );

  // Glassmorphism support - 85% opacity with 24px backdrop-blur
  static Color lightGlassSurface = lightSurfaceContainerLowest.withOpacity(0.85);
  static Color darkGlassSurface = darkSurface.withOpacity(0.85);

  // Ghost border - "Ghost Border" Fallback (15% opacity outline-variant)
  static Color lightGhostBorder = lightOutlineVariant.withOpacity(0.15);
  static Color darkGhostBorder = darkOutlineVariant.withOpacity(0.15);

  // Ambient shadow colors - Deep blue tint as specified
  static Color lightAmbientShadow = const Color(0xFF0b1c30).withOpacity(0.06); // rgba(11, 28, 48, 0.06)
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
  background: EditorialColors.lightBackground,
  onBackground: EditorialColors.lightOnSurface,
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
  background: EditorialColors.darkBackground,
  onBackground: EditorialColors.darkOnSurface,
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