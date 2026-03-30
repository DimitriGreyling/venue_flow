import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';
import 'elevation.dart';

/// Editorial Concierge Component Themes
/// Implements the "No-Line" rule and luxury wedding aesthetic
class EditorialComponents {
  EditorialComponents._();

  // BUTTON THEMES
  /// Primary: Solid primary with on-primary text. Corners use rounded-md (0.375rem)
  static ButtonStyle primaryButton(ColorScheme colorScheme) => ElevatedButton.styleFrom(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    textStyle: EditorialTypography.buttonTextStyle(colorScheme),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6), // rounded-md
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: EditorialSpacing.buttonPadding,
      vertical: EditorialSpacing.buttonPaddingVertical,
    ),
    elevation: EditorialElevation.level2,
    shadowColor: colorScheme.brightness == Brightness.dark 
        ? Colors.transparent 
        : colorScheme.primary.withOpacity(0.2),
  );

  /// Secondary: surface-container-highest background with primary text. No border.
  static ButtonStyle secondaryButton(ColorScheme colorScheme) => ElevatedButton.styleFrom(
    backgroundColor: colorScheme.surfaceContainerHighest,
    foregroundColor: colorScheme.primary,
    textStyle: EditorialTypography.buttonTextStyle(colorScheme),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: EditorialSpacing.buttonPadding,
      vertical: EditorialSpacing.buttonPaddingVertical,
    ),
    elevation: 0,
  );

  /// Tertiary: Text-only in primary, using title-sm typography with underline on hover
  static ButtonStyle tertiaryButton(ColorScheme colorScheme) => TextButton.styleFrom(
    foregroundColor: colorScheme.primary,
    textStyle: EditorialTypography.titleSmall(colorScheme),
    padding: const EdgeInsets.symmetric(
      horizontal: EditorialSpacing.spacing4,
      vertical: EditorialSpacing.spacing2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );

  // CARD THEMES
  /// Implements "Soft, pillowy depth" with hover state changes
  /// "On hover, a card should shift from surface-container-low to surface-container-lowest"
  static CardTheme cardTheme(ColorScheme colorScheme) => CardTheme(
    color: colorScheme.surfaceContainerLowest,
    shadowColor: colorScheme.brightness == Brightness.dark 
        ? Colors.transparent 
        : colorScheme.primary.withOpacity(0.04),
    elevation: EditorialElevation.level1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(EditorialSpacing.cardBorderRadius),
    ),
    margin: const EdgeInsets.symmetric(
      vertical: EditorialSpacing.spacing2,
    ),
  );

  // INPUT DECORATION THEMES
  /// "Fields should use surface-container-low as background with bottom-only 'Ghost Border'"
  /// "This mimics the look of a high-end paper form"
  static InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) => InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surfaceContainerLow,
    
    // No borders except bottom ghost border
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: colorScheme.outline.withOpacity(0.1), // 10% opacity ghost border
        width: 1,
      ),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(6),
      ),
    ),
    
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: colorScheme.outline.withOpacity(0.1),
        width: 1,
      ),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(6),
      ),
    ),
    
    // Focus: Transition bottom border to 100% opacity primary
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: colorScheme.primary,
        width: 2,
      ),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(6),
      ),
    ),
    
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: colorScheme.error,
        width: 1,
      ),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(6),
      ),
    ),
    
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: colorScheme.error,
        width: 2,
      ),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(6),
      ),
    ),
    
    contentPadding: const EdgeInsets.symmetric(
      horizontal: EditorialSpacing.formFieldPadding,
      vertical: EditorialSpacing.formFieldPadding,
    ),
    
    labelStyle: EditorialTypography.formFieldStyle(colorScheme),
    hintStyle: EditorialTypography.formFieldStyle(colorScheme).copyWith(
      color: colorScheme.onSurfaceVariant.withOpacity(0.6),
    ),
  );

  // LIST TILE THEMES
  /// Implements "No-Line" rule - no dividers between list items
  static ListTileThemeData listTileTheme(ColorScheme colorScheme) => ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: EditorialSpacing.listItemPadding,
      vertical: EditorialSpacing.spacing2,
    ),
    
    // No divider color - implements "No-Line" rule
    selectedColor: colorScheme.primary,
    iconColor: colorScheme.onSurfaceVariant,
    textColor: colorScheme.onSurface,
    
    titleTextStyle: EditorialTypography.titleMedium(colorScheme),
    subtitleTextStyle: EditorialTypography.bodySmall(colorScheme),
    leadingAndTrailingTextStyle: EditorialTypography.labelSmall(colorScheme),
    
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );

  // APP BAR THEMES
  /// Implements glassmorphism effect
  static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
    backgroundColor: colorScheme.brightness == Brightness.dark
        ? EditorialColors.darkGlassSurface
        : EditorialColors.lightGlassSurface,
    foregroundColor: colorScheme.onSurface,
    elevation: 0,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    
    titleTextStyle: EditorialTypography.venueNameStyle(colorScheme),
    toolbarTextStyle: EditorialTypography.titleMedium(colorScheme),
    
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    
    actionsIconTheme: IconThemeData(
      color: colorScheme.onSurfaceVariant,
      size: 24,
    ),
    
    iconTheme: IconThemeData(
      color: colorScheme.onSurfaceVariant,
      size: 24,
    ),
  );

  // CHIP THEMES
  /// "Use rounded-full for chips, using secondary-container for soft, pillowy look"
  static ChipThemeData chipTheme(ColorScheme colorScheme) => ChipThemeData(
    backgroundColor: colorScheme.secondaryContainer,
    selectedColor: colorScheme.primary,
    labelStyle: EditorialTypography.labelSmall(colorScheme),
    side: BorderSide.none, // No borders - follows "No-Line" rule
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)), // rounded-full
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: EditorialSpacing.spacing3,
      vertical: EditorialSpacing.spacing1,
    ),
  );

  // SPECIALIZED COMPONENTS

  /// Status chip for venue availability
  /// "Use tertiary-container (#ffe7a8) for 'Hold' dates and secondary (#685d4a) for 'Booked' dates"
  static Widget statusChip({
    required String label,
    required VenueStatus status,
    required ColorScheme colorScheme,
  }) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case VenueStatus.available:
        backgroundColor = colorScheme.primaryContainer;
        textColor = colorScheme.onPrimaryContainer;
        break;
      case VenueStatus.hold:
        backgroundColor = colorScheme.tertiaryContainer;
        textColor = colorScheme.onTertiaryContainer;
        break;
      case VenueStatus.booked:
        backgroundColor = colorScheme.secondary;
        textColor = colorScheme.onSecondary;
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50), // rounded-full
      ),
      child: Text(
        label.toUpperCase(),
        style: EditorialTypography.metadataStyle(colorScheme).copyWith(
          color: textColor,
        ),
      ),
    );
  }

  /// Editorial quote container for testimonials
  static Widget quoteContainer({
    required String quote,
    String? attribution,
    required ColorScheme colorScheme,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: EditorialSpacing.spacing6,
        top: EditorialSpacing.spacing2,
        bottom: EditorialSpacing.spacing2,
        right: EditorialSpacing.spacing4,
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote,
            style: EditorialTypography.quoteStyle(colorScheme),
          ),
          if (attribution != null) ...[
            const SizedBox(height: EditorialSpacing.spacing2),
            Text(
              '— $attribution',
              style: EditorialTypography.captionStyle(colorScheme),
            ),
          ],
        ],
      ),
    );
  }

  /// Section header with editorial styling
  static Widget sectionHeader({
    required String title,
    String? subtitle,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: EditorialTypography.sectionHeaderStyle(colorScheme),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: EditorialSpacing.spacing1),
          Text(
            subtitle,
            style: EditorialTypography.bodySmall(colorScheme),
          ),
        ],
      ],
    );
  }

  /// Editorial card with hover effects
  static Widget editorialCard({
    required Widget child,
    required ColorScheme colorScheme,
    VoidCallback? onTap,
    EdgeInsets? padding,
    bool showHover = true,
  }) {
    return Material(
      color: colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(EditorialSpacing.cardBorderRadius),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(EditorialSpacing.cardBorderRadius),
        hoverColor: showHover ? colorScheme.surfaceContainerLowest : null,
        child: Container(
          padding: padding ?? const EdgeInsets.all(EditorialSpacing.cardPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(EditorialSpacing.cardBorderRadius),
            boxShadow: EditorialElevation.cardShadow(
              colorScheme.brightness == Brightness.dark,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Venue status enumeration for status chips
enum VenueStatus {
  available,
  hold,
  booked,
}

/// Extension to disable divider theme globally
extension EditorialThemeExtensions on ThemeData {
  /// Creates theme with "No-Line" rule applied
  ThemeData get withNoLineRule => copyWith(
    dividerTheme: const DividerThemeData(
      thickness: 0,
      space: 0,
      color: Colors.transparent,
    ),
    listTileTheme: listTileTheme?.copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide.none, // No borders
      ),
    ),
  );
}