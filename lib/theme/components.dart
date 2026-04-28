import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';
import 'elevation.dart';

/// The Architectural Flow Component System
/// Implements the "No-Line" rule and "Glass & Gradient" effects
/// "Primary CTAs use gradient, Action Chips are pill-shaped, No borders for sectioning"
class EditorialComponents {
  EditorialComponents._();

  // BUTTON THEMES
  /// Primary: Gradient from primary_container to primary at 135°, 8px corners
  static ButtonStyle primaryButton(ColorScheme colorScheme) =>
      ElevatedButton.styleFrom(
        // Use gradient decoration via container - Flutter doesn't support gradient directly
        backgroundColor: colorScheme.primary, // Fallback
        foregroundColor: colorScheme.onPrimary,
        textStyle: EditorialTypography.buttonTextStyle(colorScheme),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8), // 8px as specified in design.md
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: EditorialSpacing.buttonPadding,
          vertical: EditorialSpacing.buttonPaddingVertical,
        ),
        elevation: EditorialElevation.level2,
        shadowColor: colorScheme.brightness == Brightness.dark
            ? Colors.transparent
            : const Color(0xFF0b1c30).withOpacity(0.06), // Deep blue tint
      );

  /// Secondary: surface-container-highest background with primary text. No border.
  static ButtonStyle secondaryButton(ColorScheme colorScheme) =>
      ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surfaceContainerHighest,
        foregroundColor: colorScheme.primary,
        textStyle: EditorialTypography.buttonTextStyle(colorScheme),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 8px consistency
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: EditorialSpacing.buttonPadding,
          vertical: EditorialSpacing.buttonPaddingVertical,
        ),
        elevation: 0,
      );

  /// Action Chips: Pill-shaped (full radius) to contrast architectural squareness
  static ButtonStyle actionChipButton(ColorScheme colorScheme) =>
      ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        textStyle: EditorialTypography.buttonTextStyle(colorScheme),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999), // Pill-shaped
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: EditorialSpacing.spacing4,
          vertical: EditorialSpacing.spacing2,
        ),
        elevation: 0,
      );

  /// Tertiary: Text-only in primary, clean and minimal
  static ButtonStyle tertiaryButton(ColorScheme colorScheme) =>
      TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        textStyle: EditorialTypography.titleSmall(colorScheme),
        padding: const EdgeInsets.symmetric(
          horizontal: EditorialSpacing.spacing4,
          vertical: EditorialSpacing.spacing2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );

  // CARD THEMES - Tonal Layering System
  /// "A card should never have a border. Use tonal shift for boundaries."
  /// "On hover, shift from surface-container-low to surface-container-lowest"
  static CardTheme cardTheme(ColorScheme colorScheme) => CardTheme(
        color: colorScheme.surfaceContainerLowest, // Top layer - high priority
        shadowColor: Colors.transparent, // No shadows - use tonal layering
        elevation: 0, // Tonal depth, not physical elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Premium feel
        ),
        margin: const EdgeInsets.symmetric(
          vertical: EditorialSpacing.spacing2,
        ),
      );

  // INPUT DECORATION THEMES - "No-Line" Rule
  /// "Minimalist. No background fill; only surface-variant bottom-stroke or Ghost Border"
  /// "Focus State: Transition border to secondary with soft secondary_fixed glow"
  static InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) =>
      InputDecorationTheme(
          filled: false, // No background fill as specified

          // Only bottom stroke - Ghost Border approach
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color:
                  colorScheme.outline.withOpacity(0.15), // Ghost border at 15%
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: colorScheme.outline.withOpacity(0.15), // Ghost border
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: colorScheme.secondary, // Transition to secondary on focus
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: colorScheme.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: colorScheme.error,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: EditorialSpacing.formFieldPadding,
            vertical: EditorialSpacing.spacing3,
          ),
          // labelStyle: EditorialTypography.formFieldStyle(colorScheme),
          labelStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return EditorialTypography.formFieldStyle(colorScheme).copyWith(
                color: colorScheme.onSurfaceVariant.withOpacity(0.45),
              );
            }

            if (states.contains(WidgetState.focused)) {
              return EditorialTypography.formFieldStyle(colorScheme).copyWith(
                color: colorScheme.secondary,
              );
            }

            if (states.contains(WidgetState.error)) {
              return EditorialTypography.formFieldStyle(colorScheme).copyWith(
                color: colorScheme.error,
              );
            }

            return EditorialTypography.formFieldStyle(colorScheme).copyWith(
              color: colorScheme.onSurfaceVariant,
            );
          }),
          floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return EditorialTypography.formFieldStyle(colorScheme).copyWith(
                color: colorScheme.onSurfaceVariant.withOpacity(0.4),
              );
            }

            if (states.contains(WidgetState.error)) {
              return EditorialTypography.formFieldStyle(colorScheme).copyWith(
                color: colorScheme.error,
              );
            }

            return EditorialTypography.formFieldStyle(colorScheme).copyWith(
              color: colorScheme.secondary,
            );
          }),
          hintStyle: EditorialTypography.formFieldStyle(colorScheme).copyWith(
            color: colorScheme.onSurfaceVariant.withOpacity(0.6),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: colorScheme.outline.withOpacity(0.15), // Ghost border
              width: 1,
            ),
          ));

  // LIST TILE THEMES
  /// Implements "No-Line" rule - no dividers between list items
  static ListTileThemeData listTileTheme(ColorScheme colorScheme) =>
      ListTileThemeData(
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
        leadingAndTrailingTextStyle:
            EditorialTypography.labelSmall(colorScheme),

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
          padding:
              padding ?? const EdgeInsets.all(EditorialSpacing.cardPadding),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(EditorialSpacing.cardBorderRadius),
            boxShadow: EditorialElevation.cardShadow(
              colorScheme.brightness == Brightness.dark,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // SIGNATURE ARCHITECTURAL FLOW COMPONENTS

  /// Primary CTA Button with Gradient - \"Glass & Gradient\" Rule Implementation
  static Widget primaryCtaButton({
    required String text,
    VoidCallback? onPressed,
    required ColorScheme colorScheme,
    Widget? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: EditorialColors.primaryCtaGradient, // 135-degree gradient
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0b1c30).withOpacity(0.06),
            offset: const Offset(0, 8),
            blurRadius: 32,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: icon ?? const SizedBox.shrink(),
        label:
            Text(text, style: EditorialTypography.buttonTextStyle(colorScheme)),
      ),
    );
  }

  /// Glass Panel with Backdrop Blur - For Floating Modals
  static Widget glassPanel({
    required Widget child,
    required ColorScheme colorScheme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: EditorialColors.lightGlassSurface, // 85% opacity
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      // Note: BackdropFilter with 24px blur should be implemented by parent
      child: child,
    );
  }

  /// Tonal Card - No borders, uses background shifts for boundaries
  static Widget tonalCard({
    required Widget child,
    required ColorScheme colorScheme,
    VoidCallback? onTap,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(EditorialSpacing.spacing6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest, // Top layer
        borderRadius: BorderRadius.circular(12),
        // No shadows - pure tonal layering
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: child,
        ),
      ),
    );
  }

  /// Ghost Border Divider - 15% opacity outline-variant (fallback only)
  static Widget ghostDivider(ColorScheme colorScheme) {
    return Container(
      height: 1,
      color: colorScheme.outline.withOpacity(0.15), // Ghost border
    );
  }

  /// Venue Card with XL corner radius for premium feel
  static Widget venueCard({
    required Widget child,
    required ColorScheme colorScheme,
    String? imageUrl,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24), // XL radius for premium feel
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              if (imageUrl != null)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    color: colorScheme.surfaceContainer,
                  ),
                  // Image would go here
                ),
              Padding(
                padding: const EdgeInsets.all(EditorialSpacing.spacing6),
                child: child,
              ),
            ],
          ),
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
