import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// The Architectural Flow Typography System
/// Manrope for Display & Headlines (geometric precision, tech-boutique feel)
/// Inter for Body & Labels (unparalleled legibility in data-heavy views)
/// Implements the "Editorial Authority" aesthetic
class EditorialTypography {
  EditorialTypography._();

  // Base Text Styles using Google Fonts

  /// Editorial Voice - Manrope for display, headlines, key metrics
  /// "Editorial voice with geometric precision and modern tech-boutique feel"
  static TextStyle manropeBase(ColorScheme colorScheme) => GoogleFonts.manrope(
    color: colorScheme.onSurface,
    fontWeight: FontWeight.w400,
  );

  /// Functional Voice - Inter for body text, labels, data
  /// "Unparalleled legibility for contract details, guest counts, and scheduling data"
  static TextStyle interBase(ColorScheme colorScheme) => GoogleFonts.inter(
    color: colorScheme.onSurface,
    fontWeight: FontWeight.w400,
  );

  // DISPLAY STYLES - Editorial Voice (Manrope)
  // For dashboard welcomes and key metrics - geometric precision
  static TextStyle displayLarge(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    height: 1.16,
    letterSpacing: -0.15,
  );

  static TextStyle displaySmall(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.22,
  );

  // HEADLINE STYLES - Editorial Voice (Manrope)
  // Primary statement text with tech-boutique feel
  static TextStyle headlineLarge(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static TextStyle headlineMedium(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.29,
  );

  static TextStyle headlineSmall(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  // TITLE STYLES - Mixed Voice
  static TextStyle titleLarge(ColorScheme colorScheme) => manropeBase(colorScheme).copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
  );

  static TextStyle titleMedium(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.30,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.44,
    letterSpacing: 0.1,
  );

  // BODY STYLES - Functional Voice (Inter)
  // For contract details, guest counts, scheduling data - unparalleled legibility
  static TextStyle bodyLarge(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.44,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.4,
  );

  // LABEL STYLES - Functional Voice (Inter)
  // For metadata - use on-surface-variant to maintain visual hierarchy
  static TextStyle labelLarge(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.44,
    letterSpacing: 0.1,
    color: colorScheme.onSurfaceVariant,
  );

  static TextStyle labelMedium(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.5,
    color: colorScheme.onSurfaceVariant,
  );

  static TextStyle labelSmall(ColorScheme colorScheme) => interBase(colorScheme).copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0.5,
    color: colorScheme.onSurfaceVariant,
  );

  // SPECIALIZED EDITORIAL STYLES

  /// Venue Name Style - The signature branding style
  /// Editorial voice (Manrope) with geometric precision and tech-boutique feel
  static TextStyle venueNameStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: colorScheme.primary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// Quote Style - For testimonials and featured quotes
  /// Editorial voice (Manrope) with refined emphasis
  static TextStyle quoteStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    color: colorScheme.primary,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// Metadata Style - For timestamps, counts, and secondary data
  /// Functional voice (Inter) with wide letter spacing for legibility
  static TextStyle metadataStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: colorScheme.onSurfaceVariant,
    letterSpacing: 1.5,
    height: 1.45,
  );

  /// Section Header Style - For categorical organization
  /// Editorial voice (Manrope) with uppercase and generous spacing
  static TextStyle sectionHeaderStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: colorScheme.secondary,
    letterSpacing: 2.6,
    height: 1.38,
  );

  /// Accent Text Style - For CTAs and important actions
  /// Editorial voice (Manrope) with proper weight for tech-boutique feel
  static TextStyle accentTextStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: colorScheme.tertiary,
    letterSpacing: 0.15,
    height: 1.44,
  );

  /// Caption Style - For fine print and supplementary information
  /// Functional voice (Inter) - subtle and refined, never competing
  static TextStyle captionStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: colorScheme.onSurfaceVariant.withOpacity(0.8),
    height: 1.33,
    letterSpacing: 0.4,
  );

  /// Button Text Style - For primary actions
  /// Editorial voice (Manrope) with geometric precision for tech-boutique feel
  static TextStyle buttonTextStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.25,
  );

  /// Form Field Style - For input placeholders and labels
  /// Functional voice (Inter) for maximum legibility in data entry
  static TextStyle formFieldStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: colorScheme.onSurfaceVariant,
    height: 1.44,
    letterSpacing: 0.15,
  );

  // EXPANDED LABEL STYLES

  /// Bold Label - For emphasized labels
  static TextStyle labelBold(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    height: 1.33,
    letterSpacing: 0.1,
    color: colorScheme.onSurface,
  );

  /// Uppercase Label - For section headers and categories
  static TextStyle labelUppercase(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 1.45,
    letterSpacing: 1.5,
    color: colorScheme.onSurfaceVariant,
  );

  /// Subtle Label - For secondary information
  static TextStyle labelSubtle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.38,
    letterSpacing: 0.25,
    color: colorScheme.onSurfaceVariant.withOpacity(0.7),
  );

  /// Interactive Label - For clickable elements
  static TextStyle labelInteractive(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.1,
    color: colorScheme.primary,
  );

  /// Status Label - For status indicators  
  static TextStyle labelStatus(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: 0.8,
    color: colorScheme.onSurfaceVariant,
  );

  /// Tag Label - For tags and chips
  static TextStyle labelTag(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.27,
    letterSpacing: 0.5,
    color: colorScheme.onSecondaryContainer,
  );

  /// Metric Label - For numbers and statistics (uses Manrope as specified)
  static TextStyle labelMetric(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    height: 1.25,
    letterSpacing: -0.5,
    color: colorScheme.primary,
  );

  /// Error Label - For error messages
  static TextStyle labelError(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.38,
    letterSpacing: 0.25,
    color: colorScheme.error,
  );

  /// Success Label - For success messages
  static TextStyle labelSuccess(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.38,
    letterSpacing: 0.25,
    color: colorScheme.primary,
  );

  /// Warning Label - For warning messages
  static TextStyle labelWarning(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.38,
    letterSpacing: 0.25,
    color: colorScheme.tertiary,
  );

  // SPECIALIZED EDITORIAL STYLES

  /// Card Title Style - For card headers (Manrope editorial voice)
  static TextStyle cardTitleStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.15,
    color: colorScheme.onSurface,
  );

  /// Card Subtitle Style - For card secondary text (Inter functional voice)
  static TextStyle cardSubtitleStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.25,
    color: colorScheme.onSurfaceVariant,
  );

  /// Navigation Label - For navigation items (Inter)
  static TextStyle navigationLabel(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
    color: colorScheme.onSurfaceVariant,
  );

  /// Tab Label - For tab bar labels (Inter)
  static TextStyle tabLabel(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
    color: colorScheme.primary,
  );

  /// Breadcrumb Style - For breadcrumb navigation (Inter)
  static TextStyle breadcrumbStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.38,
    letterSpacing: 0.25,
    color: colorScheme.onSurfaceVariant,
  );

  /// Timestamp Style - For dates and times (Inter)
  static TextStyle timestampStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.4,
    color: colorScheme.outline,
  );

  /// Price Style - For monetary values (Manrope for designed look)
  static TextStyle priceStyle(ColorScheme colorScheme) => GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.30,
    letterSpacing: -0.15,
    color: colorScheme.primary,
  );

  /// Link Style - For clickable links (Inter)
  static TextStyle linkStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.50,
    letterSpacing: 0.15,
    color: colorScheme.secondary,
    decoration: TextDecoration.underline,
    decorationColor: colorScheme.secondary.withOpacity(0.6),
  );

  /// Helper Text Style - For form helper text (Inter)
  static TextStyle helperTextStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
    color: colorScheme.onSurfaceVariant.withOpacity(0.8),
  );

  /// Placeholder Style - For input placeholders (Inter)
  static TextStyle placeholderStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0.15,
    color: colorScheme.onSurfaceVariant.withOpacity(0.6),
  );

  /// Tooltip Style - For tooltip text (Inter)
  static TextStyle tooltipStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.4,
    color: colorScheme.onInverseSurface,
  );

  /// Badge Style - For notification badges (Inter)
  static TextStyle badgeStyle(ColorScheme colorScheme) => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    height: 1.20,
    letterSpacing: 0.5,
    color: colorScheme.onError,
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