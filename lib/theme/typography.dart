import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// The Editorial Concierge Typography System
/// High-contrast pairing: Noto Serif for editorial voice, Manrope for functional voice
/// Implements the luxury wedding invitation aesthetic
class EditorialTypography {
  EditorialTypography._();

  // Base Text Styles using Google Fonts

  /// Editorial Voice - Noto Serif for statements, headlines, venue names
  /// "These are our statements - the serif evokes tradition, elegance, and timelessness"
  static TextStyle notoSerifBase(ColorScheme colorScheme) => GoogleFonts.notoSerif(
    color: colorScheme.onSurface,
    fontWeight: FontWeight.w400,
  );

  /// Functional Voice - Manrope for body text, labels, data
  /// "Our functional voice - ensures high legibility for contract details, guest counts, and scheduling data"
  static TextStyle manropeBase(ColorScheme colorScheme) => GoogleFonts.manrope(
    color: colorScheme.onSurface,
    fontWeight: FontWeight.w400,
  );

  // DISPLAY STYLES - Editorial Voice (Noto Serif)
  // For dashboard welcomes and venue names
  static TextStyle displayLarge(ColorScheme colorScheme) => notoSerifBase(colorScheme).copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium(ColorScheme colorScheme) => notoSerifBase(colorScheme).copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    height: 1.16,
    letterSpacing: -0.15,
  );

  static TextStyle displaySmall(ColorScheme colorScheme) => notoSerifBase(colorScheme).copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.22,
  );

  // HEADLINE STYLES - Editorial Voice (Noto Serif)
  // Primary statement text
  static TextStyle headlineLarge(ColorScheme colorScheme) => notoSerifBase(colorScheme).copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static TextStyle headlineMedium(ColorScheme colorScheme) => notoSerifBase(colorScheme).copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.29,
  );

  static TextStyle headlineSmall(ColorScheme colorScheme) => notoSerifBase(colorScheme).copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  // TITLE STYLES - Mixed Voice
  static TextStyle titleLarge(ColorScheme colorScheme) => notoSerifBase(colorScheme).copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
  );

  static TextStyle titleMedium(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.30,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.44,
    letterSpacing: 0.1,
  );

  // BODY STYLES - Functional Voice (Manrope)
  // For contract details, guest counts, scheduling data
  static TextStyle bodyLarge(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.44,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.4,
  );

  // LABEL STYLES - Functional Voice (Manrope)
  // For metadata - use on-surface-variant to maintain visual hierarchy
  static TextStyle labelLarge(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.44,
    letterSpacing: 0.1,
    color: colorScheme.onSurfaceVariant,
  );

  static TextStyle labelMedium(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.5,
    color: colorScheme.onSurfaceVariant,
  );

  static TextStyle labelSmall(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0.5,
    color: colorScheme.onSurfaceVariant,
  );

  // SPECIALIZED EDITORIAL STYLES

  /// Venue Name Style - The signature branding style
  /// Editorial voice with deep slate color and refined spacing
  static TextStyle venueNameStyle(ColorScheme colorScheme) => GoogleFonts.notoSerif(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: colorScheme.primary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// Quote Style - For testimonials and featured quotes
  /// Editorial voice with italic emphasis
  static TextStyle quoteStyle(ColorScheme colorScheme) => GoogleFonts.notoSerif(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: colorScheme.primary,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// Metadata Style - For timestamps, counts, and secondary data
  /// Small caps effect with wide letter spacing
  static TextStyle metadataStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: colorScheme.onSurfaceVariant,
    letterSpacing: 1.5,
    height: 1.45,
  );

  /// Section Header Style - For categorical organization
  /// Uppercase with generous spacing for editorial feel
  static TextStyle sectionHeaderStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: colorScheme.secondary,
    letterSpacing: 2.6,
    height: 1.38,
  );

  /// Accent Text Style - For CTAs and important actions
  /// Clean functional style with proper weight
  static TextStyle accentTextStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: colorScheme.tertiary,
    letterSpacing: 0.15,
    height: 1.44,
  );

  /// Caption Style - For fine print and supplementary information
  /// Subtle and refined, never competing with primary content
  static TextStyle captionStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: colorScheme.onSurfaceVariant.withOpacity(0.8),
    height: 1.33,
    letterSpacing: 0.4,
  );

  /// Button Text Style - For primary actions
  /// Medium weight for legibility within interactive elements
  static TextStyle buttonTextStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.25,
  );

  /// Form Field Style - For input placeholders and labels
  /// Balanced between functional and friendly
  static TextStyle formFieldStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: colorScheme.onSurfaceVariant,
    height: 1.44,
    letterSpacing: 0.15,
  );
}

/// Material 3 TextTheme for Editorial Concierge (Light Mode)
TextTheme editorialLightTextTheme = TextTheme(
  displayLarge: EditorialTypography.displayLarge(lightEditorialColorScheme),
  displayMedium: EditorialTypography.displayMedium(lightEditorialColorScheme),
  displaySmall: EditorialTypography.displaySmall(lightEditorialColorScheme),
  headlineLarge: EditorialTypography.headlineLarge(lightEditorialColorScheme),
  headlineMedium: EditorialTypography.headlineMedium(lightEditorialColorScheme),
  headlineSmall: EditorialTypography.headlineSmall(lightEditorialColorScheme),
  titleLarge: EditorialTypography.titleLarge(lightEditorialColorScheme),
  titleMedium: EditorialTypography.titleMedium(lightEditorialColorScheme),
  titleSmall: EditorialTypography.titleSmall(lightEditorialColorScheme),
  bodyLarge: EditorialTypography.bodyLarge(lightEditorialColorScheme),
  bodyMedium: EditorialTypography.bodyMedium(lightEditorialColorScheme),
  bodySmall: EditorialTypography.bodySmall(lightEditorialColorScheme),
  labelLarge: EditorialTypography.labelLarge(lightEditorialColorScheme),
  labelMedium: EditorialTypography.labelMedium(lightEditorialColorScheme),
  labelSmall: EditorialTypography.labelSmall(lightEditorialColorScheme),
);

/// Material 3 TextTheme for Editorial Concierge (Dark Mode)
TextTheme editorialDarkTextTheme = TextTheme(
  displayLarge: EditorialTypography.displayLarge(darkEditorialColorScheme),
  displayMedium: EditorialTypography.displayMedium(darkEditorialColorScheme),
  displaySmall: EditorialTypography.displaySmall(darkEditorialColorScheme),
  headlineLarge: EditorialTypography.headlineLarge(darkEditorialColorScheme),
  headlineMedium: EditorialTypography.headlineMedium(darkEditorialColorScheme),
  headlineSmall: EditorialTypography.headlineSmall(darkEditorialColorScheme),
  titleLarge: EditorialTypography.titleLarge(darkEditorialColorScheme),
  titleMedium: EditorialTypography.titleMedium(darkEditorialColorScheme),
  titleSmall: EditorialTypography.titleSmall(darkEditorialColorScheme),
  bodyLarge: EditorialTypography.bodyLarge(darkEditorialColorScheme),
  bodyMedium: EditorialTypography.bodyMedium(darkEditorialColorScheme),
  bodySmall: EditorialTypography.bodySmall(darkEditorialColorScheme),
  labelLarge: EditorialTypography.labelLarge(darkEditorialColorScheme),
  labelMedium: EditorialTypography.labelMedium(darkEditorialColorScheme),
  labelSmall: EditorialTypography.labelSmall(darkEditorialColorScheme),
);