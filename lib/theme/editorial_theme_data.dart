import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';
import 'elevation.dart';

/// Custom theme extension for Editorial Concierge specific styles
/// Provides access to specialized editorial typography and design elements
@immutable
class EditorialThemeData extends ThemeExtension<EditorialThemeData> {
  final TextStyle venueNameStyle;
  final TextStyle quoteStyle;
  final TextStyle metadataStyle;
  final TextStyle sectionHeaderStyle;
  final TextStyle accentTextStyle;
  final TextStyle captionStyle;
  final TextStyle buttonTextStyle;
  final TextStyle formFieldStyle;
  
  final LinearGradient silkSheen;
  final Color glassSurface;
  final Color ghostBorder;
  final Color ambientShadowColor;
  
  final double editorialAsymmetryLeft;
  final double editorialAsymmetryRight;
  final double breathabilitySpacing;
  final double layerOverlap;

  const EditorialThemeData({
    required this.venueNameStyle,
    required this.quoteStyle,
    required this.metadataStyle,
    required this.sectionHeaderStyle,
    required this.accentTextStyle,
    required this.captionStyle,
    required this.buttonTextStyle,
    required this.formFieldStyle,
    required this.silkSheen,
    required this.glassSurface,
    required this.ghostBorder,
    required this.ambientShadowColor,
    required this.editorialAsymmetryLeft,
    required this.editorialAsymmetryRight,
    required this.breathabilitySpacing,
    required this.layerOverlap,
  });

  /// Light theme editorial data
  factory EditorialThemeData.light() {
    final colorScheme = lightEditorialColorScheme;
    return EditorialThemeData(
      venueNameStyle: EditorialTypography.venueNameStyle(colorScheme),
      quoteStyle: EditorialTypography.quoteStyle(colorScheme),
      metadataStyle: EditorialTypography.metadataStyle(colorScheme),
      sectionHeaderStyle: EditorialTypography.sectionHeaderStyle(colorScheme),
      accentTextStyle: EditorialTypography.accentTextStyle(colorScheme),
      captionStyle: EditorialTypography.captionStyle(colorScheme),
      buttonTextStyle: EditorialTypography.buttonTextStyle(colorScheme),
      formFieldStyle: EditorialTypography.formFieldStyle(colorScheme),
      silkSheen: EditorialColors.silkSheen,
      glassSurface: EditorialColors.lightGlassSurface,
      ghostBorder: EditorialColors.lightGhostBorder,
      ambientShadowColor: EditorialColors.lightAmbientShadow,
      editorialAsymmetryLeft: EditorialSpacing.editorialHeroLeftLarge,
      editorialAsymmetryRight: EditorialSpacing.editorialHeroRightLarge,
      breathabilitySpacing: EditorialSpacing.breathabilityMajor,
      layerOverlap: EditorialSpacing.layerOverlapLarge,
    );
  }

  /// Dark theme editorial data
  factory EditorialThemeData.dark() {
    final colorScheme = darkEditorialColorScheme;
    return EditorialThemeData(
      venueNameStyle: EditorialTypography.venueNameStyle(colorScheme),
      quoteStyle: EditorialTypography.quoteStyle(colorScheme),
      metadataStyle: EditorialTypography.metadataStyle(colorScheme),
      sectionHeaderStyle: EditorialTypography.sectionHeaderStyle(colorScheme),
      accentTextStyle: EditorialTypography.accentTextStyle(colorScheme),
      captionStyle: EditorialTypography.captionStyle(colorScheme),
      buttonTextStyle: EditorialTypography.buttonTextStyle(colorScheme),
      formFieldStyle: EditorialTypography.formFieldStyle(colorScheme),
      silkSheen: EditorialColors.darkSilkSheen,
      glassSurface: EditorialColors.darkGlassSurface,
      ghostBorder: EditorialColors.darkGhostBorder,
      ambientShadowColor: EditorialColors.darkAmbientShadow,
      editorialAsymmetryLeft: EditorialSpacing.editorialHeroLeftLarge,
      editorialAsymmetryRight: EditorialSpacing.editorialHeroRightLarge,
      breathabilitySpacing: EditorialSpacing.breathabilityMajor,
      layerOverlap: EditorialSpacing.layerOverlapLarge,
    );
  }

  @override
  EditorialThemeData copyWith({
    TextStyle? venueNameStyle,
    TextStyle? quoteStyle,
    TextStyle? metadataStyle,
    TextStyle? sectionHeaderStyle,
    TextStyle? accentTextStyle,
    TextStyle? captionStyle,
    TextStyle? buttonTextStyle,
    TextStyle? formFieldStyle,
    LinearGradient? silkSheen,
    Color? glassSurface,
    Color? ghostBorder,
    Color? ambientShadowColor,
    double? editorialAsymmetryLeft,
    double? editorialAsymmetryRight,
    double? breathabilitySpacing,
    double? layerOverlap,
  }) {
    return EditorialThemeData(
      venueNameStyle: venueNameStyle ?? this.venueNameStyle,
      quoteStyle: quoteStyle ?? this.quoteStyle,
      metadataStyle: metadataStyle ?? this.metadataStyle,
      sectionHeaderStyle: sectionHeaderStyle ?? this.sectionHeaderStyle,
      accentTextStyle: accentTextStyle ?? this.accentTextStyle,
      captionStyle: captionStyle ?? this.captionStyle,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      formFieldStyle: formFieldStyle ?? this.formFieldStyle,
      silkSheen: silkSheen ?? this.silkSheen,
      glassSurface: glassSurface ?? this.glassSurface,
      ghostBorder: ghostBorder ?? this.ghostBorder,
      ambientShadowColor: ambientShadowColor ?? this.ambientShadowColor,
      editorialAsymmetryLeft: editorialAsymmetryLeft ?? this.editorialAsymmetryLeft,
      editorialAsymmetryRight: editorialAsymmetryRight ?? this.editorialAsymmetryRight,
      breathabilitySpacing: breathabilitySpacing ?? this.breathabilitySpacing,
      layerOverlap: layerOverlap ?? this.layerOverlap,
    );
  }

  @override
  EditorialThemeData lerp(EditorialThemeData? other, double t) {
    if (other is! EditorialThemeData) {
      return this;
    }
    return EditorialThemeData(
      venueNameStyle: TextStyle.lerp(venueNameStyle, other.venueNameStyle, t)!,
      quoteStyle: TextStyle.lerp(quoteStyle, other.quoteStyle, t)!,
      metadataStyle: TextStyle.lerp(metadataStyle, other.metadataStyle, t)!,
      sectionHeaderStyle: TextStyle.lerp(sectionHeaderStyle, other.sectionHeaderStyle, t)!,
      accentTextStyle: TextStyle.lerp(accentTextStyle, other.accentTextStyle, t)!,
      captionStyle: TextStyle.lerp(captionStyle, other.captionStyle, t)!,
      buttonTextStyle: TextStyle.lerp(buttonTextStyle, other.buttonTextStyle, t)!,
      formFieldStyle: TextStyle.lerp(formFieldStyle, other.formFieldStyle, t)!,
      silkSheen: LinearGradient.lerp(silkSheen, other.silkSheen, t)!,
      glassSurface: Color.lerp(glassSurface, other.glassSurface, t)!,
      ghostBorder: Color.lerp(ghostBorder, other.ghostBorder, t)!,
      ambientShadowColor: Color.lerp(ambientShadowColor, other.ambientShadowColor, t)!,
      editorialAsymmetryLeft: EditorialOffset.lerpDouble(editorialAsymmetryLeft, other.editorialAsymmetryLeft, t),
      editorialAsymmetryRight: EditorialOffset.lerpDouble(editorialAsymmetryRight, other.editorialAsymmetryRight, t),
      breathabilitySpacing: EditorialOffset.lerpDouble(breathabilitySpacing, other.breathabilitySpacing, t),
      layerOverlap: EditorialOffset.lerpDouble(layerOverlap, other.layerOverlap, t),
    );
  }
}

/// Helper class for double lerping
class EditorialOffset {
  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

/// Extension to access editorial theme data easily
extension EditorialThemeExtension on ThemeData {
  EditorialThemeData get editorial => extension<EditorialThemeData>()!;
}

/// Helper to access editorial theme from context
extension EditorialBuildContext on BuildContext {
  EditorialThemeData get editorial => Theme.of(this).editorial;
}