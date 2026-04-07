import 'package:flutter/material.dart';
import 'colors.dart';

/// The Architectural Flow Elevation & Tonal Layering System
/// "Shadows are light, borders are invisible" - implements tonal depth
/// Rejects standard drop shadow approach for atmospheric tonal layering
class EditorialElevation {
  EditorialElevation._();

  // TONAL LAYERING LEVELS
  /// Surface elevation levels for tonal architecture
  static const double level0 = 0; // Base layer - background (#f8f9ff)
  static const double level1 = 1; // Mid layer - surface-container (#e5eeff)
  static const double level2 = 2; // Top layer - surface-container-lowest (#ffffff)
  static const double level3 = 4; // Floating elements when absolutely necessary

  // AMBIENT SHADOWS - Deep Blue Tinted
  /// "For floating elements (modals, dropdowns), use 32px blur with 6% opacity, 
  /// tinted with atmospheric blue rgba(11, 28, 48, 0.06). Mimics natural light."
  
  /// Primary ambient shadow for floating elements - Deep Blue Tinted
  static List<BoxShadow> ambientShadow(bool isDark) => [
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.12)
          : const Color(0xFF0b1c30).withOpacity(0.06), // Deep blue tint
      offset: const Offset(0, 8), // 8px Y-offset as specified
      blurRadius: 32, // 32px blur
      spreadRadius: 0,
    ),
  ];

  /// Minimal card elevation - barely perceptible tonal shift
  /// Uses tonal layering instead of shadows
  static List<BoxShadow> cardShadow(bool isDark) => [
    // Minimal shadow for floating feel only when absolutely necessary
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.04)
          : const Color(0xFF0b1c30).withOpacity(0.02), // Atmospheric blue tint
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  /// Interactive element shadow - minimal response to user interaction
  static List<BoxShadow> interactiveShadow(bool isDark) => [
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.08)
          : const Color(0xFF0b1c30).withOpacity(0.04), // Atmospheric blue tint
      offset: const Offset(0, 4),
      blurRadius: 16,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.06)
          : EditorialColors.lightPrimary.withOpacity(0.02),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];

  /// Modal and overlay shadow - highest elevation
  static List<BoxShadow> modalShadow(bool isDark) => [
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.20)
          : EditorialColors.lightPrimary.withOpacity(0.08),
      offset: const Offset(0, 20),
      blurRadius: 48,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.12)
          : EditorialColors.lightPrimary.withOpacity(0.04),
      offset: const Offset(0, 8),
      blurRadius: 32,
      spreadRadius: -8,
    ),
  ];

  /// Navigation shadow - for glassmorphism effect
  static List<BoxShadow> navigationShadow(bool isDark) => [
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.16)
          : EditorialColors.lightPrimary.withOpacity(0.03),
      offset: const Offset(0, 4),
      blurRadius: 20,
      spreadRadius: -2,
    ),
  ];

  /// Subtle hover effect shadow
  static List<BoxShadow> hoverShadow(bool isDark) => [
    BoxShadow(
      color: isDark 
          ? Colors.black.withOpacity(0.10)
          : EditorialColors.lightPrimary.withOpacity(0.04),
      offset: const Offset(0, 6),
      blurRadius: 20,
      spreadRadius: -2,
    ),
  ];

  // DEPTH AND LAYERING
  /// "Depth is achieved by stacking. Place a surface-container-lowest card 
  /// on a surface-container-high background. This creates natural 'lift.'"

  /// Z-index equivalent values for stacking context
  static const double baseLayer = 0;
  static const double cardLayer = 1;
  static const double interactiveLayer = 2;
  static const double navigationLayer = 10;
  static const double drawerLayer = 15;
  static const double modalLayer = 20;
  static const double tooltipLayer = 25;

  // GLASSMORPHISM SUPPORT
  /// "For top navigation bars or floating action buttons, use surface at 80% 
  /// opacity with backdrop-blur(12px)"
  
  /// Glass surface color with appropriate opacity
  static Color glassSurface(bool isDark) => isDark 
      ? EditorialColors.darkGlassSurface
      : EditorialColors.lightGlassSurface;

  /// Blur radius for glassmorphism effects
  static const double glassBlurRadius = 12.0;

  // MATERIAL 3 ELEVATION MAPPING
  /// Custom elevation values that align with Editorial Concierge aesthetic
  /// while remaining compatible with Material 3

  /// Level 4 - Menu and dropdown overlays
  static const double level4 = 8.0;

  /// Level 5 - Modal and dialog overlays
  static const double level5 = 12.0;

  // SHADOW FACTORY METHODS
  /// Create appropriate shadow based on elevation level
  static List<BoxShadow> shadowForElevation(double elevation, bool isDark) {
    if (elevation <= level0) {
      return [];
    } else if (elevation <= level1) {
      return cardShadow(isDark);
    } else if (elevation <= level2) {
      return interactiveShadow(isDark);
    } else if (elevation <= level3) {
      return navigationShadow(isDark);
    } else if (elevation <= level4) {
      return hoverShadow(isDark);
    } else {
      return modalShadow(isDark);
    }
  }

  /// Create shadow for specific component types
  static List<BoxShadow> shadowForComponent(EditorialShadowType type, bool isDark) {
    switch (type) {
      case EditorialShadowType.card:
        return cardShadow(isDark);
      case EditorialShadowType.interactive:
        return interactiveShadow(isDark);
      case EditorialShadowType.navigation:
        return navigationShadow(isDark);
      case EditorialShadowType.modal:
        return modalShadow(isDark);
      case EditorialShadowType.ambient:
        return ambientShadow(isDark);
      case EditorialShadowType.hover:
        return hoverShadow(isDark);
    }
  }
}

/// Shadow types for semantic usage
enum EditorialShadowType {
  card,
  interactive,
  navigation,
  modal,
  ambient,
  hover,
}

/// Extension for convenient shadow access on containers
extension EditorialBoxShadow on BoxDecoration {
  /// Add Editorial shadow to existing BoxDecoration
  BoxDecoration withEditorialShadow(EditorialShadowType type, bool isDark) {
    return copyWith(
      boxShadow: EditorialElevation.shadowForComponent(type, isDark),
    );
  }

  /// Add Editorial elevation shadow to existing BoxDecoration
  BoxDecoration withEditorialElevation(double elevation, bool isDark) {
    return copyWith(
      boxShadow: EditorialElevation.shadowForElevation(elevation, isDark),
    );
  }
}

/// Helper for creating glassmorphism containers
class EditorialGlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final bool isDark;

  const EditorialGlassContainer({
    super.key,
    required this.child,
    required this.isDark,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: EditorialElevation.glassSurface(isDark),
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        boxShadow: EditorialElevation.navigationShadow(isDark),
        border: Border.all(
          color: isDark 
              ? EditorialColors.darkGhostBorder
              : EditorialColors.lightGhostBorder,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}