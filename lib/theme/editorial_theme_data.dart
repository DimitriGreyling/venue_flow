import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';
import 'elevation.dart';

/// Custom theme extension for Editorial Concierge specific styles
/// Provides access to specialized editorial typography and design elements
@immutable
class EditorialThemeData extends ThemeExtension<EditorialThemeData> {
  // Original Editorial Styles
  final TextStyle venueNameStyle;
  final TextStyle quoteStyle;
  final TextStyle metadataStyle;
  final TextStyle sectionHeaderStyle;
  final TextStyle accentTextStyle;
  final TextStyle captionStyle;
  final TextStyle buttonTextStyle;
  final TextStyle formFieldStyle;
  
  // Extended Label Styles
  final TextStyle labelBold;
  final TextStyle labelUppercase;
  final TextStyle labelSubtle;
  final TextStyle labelInteractive;
  final TextStyle labelStatus;
  final TextStyle labelTag;
  final TextStyle labelMetric;
  final TextStyle labelError;
  final TextStyle labelSuccess;
  final TextStyle labelWarning;
  
  // Specialized Component Styles
  final TextStyle cardTitleStyle;
  final TextStyle cardSubtitleStyle;
  final TextStyle navigationLabel;
  final TextStyle tabLabel;
  final TextStyle breadcrumbStyle;
  final TextStyle timestampStyle;
  final TextStyle priceStyle;
  final TextStyle linkStyle;
  final TextStyle helperTextStyle;
  final TextStyle placeholderStyle;
  final TextStyle tooltipStyle;
  final TextStyle badgeStyle;
  
  final LinearGradient silkSheen;
  final Color glassSurface;
  final Color ghostBorder;
  final Color ambientShadowColor;
  
  final double editorialAsymmetryLeft;
  final double editorialAsymmetryRight;
  final double breathabilitySpacing;
  final double layerOverlap;

  const EditorialThemeData({
    // Original Editorial Styles
    required this.venueNameStyle,
    required this.quoteStyle,
    required this.metadataStyle,
    required this.sectionHeaderStyle,
    required this.accentTextStyle,
    required this.captionStyle,
    required this.buttonTextStyle,
    required this.formFieldStyle,
    // Extended Label Styles
    required this.labelBold,
    required this.labelUppercase,
    required this.labelSubtle,
    required this.labelInteractive,
    required this.labelStatus,
    required this.labelTag,
    required this.labelMetric,
    required this.labelError,
    required this.labelSuccess,
    required this.labelWarning,
    // Specialized Component Styles
    required this.cardTitleStyle,
    required this.cardSubtitleStyle,
    required this.navigationLabel,
    required this.tabLabel,
    required this.breadcrumbStyle,
    required this.timestampStyle,
    required this.priceStyle,
    required this.linkStyle,
    required this.helperTextStyle,
    required this.placeholderStyle,
    required this.tooltipStyle,
    required this.badgeStyle,
    // Visual Elements
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
      // Original Editorial Styles
      venueNameStyle: EditorialTypography.venueNameStyle(colorScheme),
      quoteStyle: EditorialTypography.quoteStyle(colorScheme),
      metadataStyle: EditorialTypography.metadataStyle(colorScheme),
      sectionHeaderStyle: EditorialTypography.sectionHeaderStyle(colorScheme),
      accentTextStyle: EditorialTypography.accentTextStyle(colorScheme),
      captionStyle: EditorialTypography.captionStyle(colorScheme),
      buttonTextStyle: EditorialTypography.buttonTextStyle(colorScheme),
      formFieldStyle: EditorialTypography.formFieldStyle(colorScheme),
      // Extended Label Styles
      labelBold: EditorialTypography.labelBold(colorScheme),
      labelUppercase: EditorialTypography.labelUppercase(colorScheme),
      labelSubtle: EditorialTypography.labelSubtle(colorScheme),
      labelInteractive: EditorialTypography.labelInteractive(colorScheme),
      labelStatus: EditorialTypography.labelStatus(colorScheme),
      labelTag: EditorialTypography.labelTag(colorScheme),
      labelMetric: EditorialTypography.labelMetric(colorScheme),
      labelError: EditorialTypography.labelError(colorScheme),
      labelSuccess: EditorialTypography.labelSuccess(colorScheme),
      labelWarning: EditorialTypography.labelWarning(colorScheme),
      // Specialized Component Styles
      cardTitleStyle: EditorialTypography.cardTitleStyle(colorScheme),
      cardSubtitleStyle: EditorialTypography.cardSubtitleStyle(colorScheme),
      navigationLabel: EditorialTypography.navigationLabel(colorScheme),
      tabLabel: EditorialTypography.tabLabel(colorScheme),
      breadcrumbStyle: EditorialTypography.breadcrumbStyle(colorScheme),
      timestampStyle: EditorialTypography.timestampStyle(colorScheme),
      priceStyle: EditorialTypography.priceStyle(colorScheme),
      linkStyle: EditorialTypography.linkStyle(colorScheme),
      helperTextStyle: EditorialTypography.helperTextStyle(colorScheme),
      placeholderStyle: EditorialTypography.placeholderStyle(colorScheme),
      tooltipStyle: EditorialTypography.tooltipStyle(colorScheme),
      badgeStyle: EditorialTypography.badgeStyle(colorScheme),
      // Visual Elements
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
      // Original Editorial Styles
      venueNameStyle: EditorialTypography.venueNameStyle(colorScheme),
      quoteStyle: EditorialTypography.quoteStyle(colorScheme),
      metadataStyle: EditorialTypography.metadataStyle(colorScheme),
      sectionHeaderStyle: EditorialTypography.sectionHeaderStyle(colorScheme),
      accentTextStyle: EditorialTypography.accentTextStyle(colorScheme),
      captionStyle: EditorialTypography.captionStyle(colorScheme),
      buttonTextStyle: EditorialTypography.buttonTextStyle(colorScheme),
      formFieldStyle: EditorialTypography.formFieldStyle(colorScheme),
      // Extended Label Styles
      labelBold: EditorialTypography.labelBold(colorScheme),
      labelUppercase: EditorialTypography.labelUppercase(colorScheme),
      labelSubtle: EditorialTypography.labelSubtle(colorScheme),
      labelInteractive: EditorialTypography.labelInteractive(colorScheme),
      labelStatus: EditorialTypography.labelStatus(colorScheme),
      labelTag: EditorialTypography.labelTag(colorScheme),
      labelMetric: EditorialTypography.labelMetric(colorScheme),
      labelError: EditorialTypography.labelError(colorScheme),
      labelSuccess: EditorialTypography.labelSuccess(colorScheme),
      labelWarning: EditorialTypography.labelWarning(colorScheme),
      // Specialized Component Styles
      cardTitleStyle: EditorialTypography.cardTitleStyle(colorScheme),
      cardSubtitleStyle: EditorialTypography.cardSubtitleStyle(colorScheme),
      navigationLabel: EditorialTypography.navigationLabel(colorScheme),
      tabLabel: EditorialTypography.tabLabel(colorScheme),
      breadcrumbStyle: EditorialTypography.breadcrumbStyle(colorScheme),
      timestampStyle: EditorialTypography.timestampStyle(colorScheme),
      priceStyle: EditorialTypography.priceStyle(colorScheme),
      linkStyle: EditorialTypography.linkStyle(colorScheme),
      helperTextStyle: EditorialTypography.helperTextStyle(colorScheme),
      placeholderStyle: EditorialTypography.placeholderStyle(colorScheme),
      tooltipStyle: EditorialTypography.tooltipStyle(colorScheme),
      badgeStyle: EditorialTypography.badgeStyle(colorScheme),
      // Visual Elements
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
    // Original Editorial Styles
    TextStyle? venueNameStyle,
    TextStyle? quoteStyle,
    TextStyle? metadataStyle,
    TextStyle? sectionHeaderStyle,
    TextStyle? accentTextStyle,
    TextStyle? captionStyle,
    TextStyle? buttonTextStyle,
    TextStyle? formFieldStyle,
    // Extended Label Styles
    TextStyle? labelBold,
    TextStyle? labelUppercase,
    TextStyle? labelSubtle,
    TextStyle? labelInteractive,
    TextStyle? labelStatus,
    TextStyle? labelTag,
    TextStyle? labelMetric,
    TextStyle? labelError,
    TextStyle? labelSuccess,
    TextStyle? labelWarning,
    // Specialized Component Styles
    TextStyle? cardTitleStyle,
    TextStyle? cardSubtitleStyle,
    TextStyle? navigationLabel,
    TextStyle? tabLabel,
    TextStyle? breadcrumbStyle,
    TextStyle? timestampStyle,
    TextStyle? priceStyle,
    TextStyle? linkStyle,
    TextStyle? helperTextStyle,
    TextStyle? placeholderStyle,
    TextStyle? tooltipStyle,
    TextStyle? badgeStyle,
    // Visual Elements
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
      // Original Editorial Styles
      venueNameStyle: venueNameStyle ?? this.venueNameStyle,
      quoteStyle: quoteStyle ?? this.quoteStyle,
      metadataStyle: metadataStyle ?? this.metadataStyle,
      sectionHeaderStyle: sectionHeaderStyle ?? this.sectionHeaderStyle,
      accentTextStyle: accentTextStyle ?? this.accentTextStyle,
      captionStyle: captionStyle ?? this.captionStyle,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      formFieldStyle: formFieldStyle ?? this.formFieldStyle,
      // Extended Label Styles
      labelBold: labelBold ?? this.labelBold,
      labelUppercase: labelUppercase ?? this.labelUppercase,
      labelSubtle: labelSubtle ?? this.labelSubtle,
      labelInteractive: labelInteractive ?? this.labelInteractive,
      labelStatus: labelStatus ?? this.labelStatus,
      labelTag: labelTag ?? this.labelTag,
      labelMetric: labelMetric ?? this.labelMetric,
      labelError: labelError ?? this.labelError,
      labelSuccess: labelSuccess ?? this.labelSuccess,
      labelWarning: labelWarning ?? this.labelWarning,
      // Specialized Component Styles
      cardTitleStyle: cardTitleStyle ?? this.cardTitleStyle,
      cardSubtitleStyle: cardSubtitleStyle ?? this.cardSubtitleStyle,
      navigationLabel: navigationLabel ?? this.navigationLabel,
      tabLabel: tabLabel ?? this.tabLabel,
      breadcrumbStyle: breadcrumbStyle ?? this.breadcrumbStyle,
      timestampStyle: timestampStyle ?? this.timestampStyle,
      priceStyle: priceStyle ?? this.priceStyle,
      linkStyle: linkStyle ?? this.linkStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      tooltipStyle: tooltipStyle ?? this.tooltipStyle,
      badgeStyle: badgeStyle ?? this.badgeStyle,
      // Visual Elements
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
      // Original Editorial Styles
      venueNameStyle: TextStyle.lerp(venueNameStyle, other.venueNameStyle, t)!,
      quoteStyle: TextStyle.lerp(quoteStyle, other.quoteStyle, t)!,
      metadataStyle: TextStyle.lerp(metadataStyle, other.metadataStyle, t)!,
      sectionHeaderStyle: TextStyle.lerp(sectionHeaderStyle, other.sectionHeaderStyle, t)!,
      accentTextStyle: TextStyle.lerp(accentTextStyle, other.accentTextStyle, t)!,
      captionStyle: TextStyle.lerp(captionStyle, other.captionStyle, t)!,
      buttonTextStyle: TextStyle.lerp(buttonTextStyle, other.buttonTextStyle, t)!,
      formFieldStyle: TextStyle.lerp(formFieldStyle, other.formFieldStyle, t)!,
      // Extended Label Styles
      labelBold: TextStyle.lerp(labelBold, other.labelBold, t)!,
      labelUppercase: TextStyle.lerp(labelUppercase, other.labelUppercase, t)!,
      labelSubtle: TextStyle.lerp(labelSubtle, other.labelSubtle, t)!,
      labelInteractive: TextStyle.lerp(labelInteractive, other.labelInteractive, t)!,
      labelStatus: TextStyle.lerp(labelStatus, other.labelStatus, t)!,
      labelTag: TextStyle.lerp(labelTag, other.labelTag, t)!,
      labelMetric: TextStyle.lerp(labelMetric, other.labelMetric, t)!,
      labelError: TextStyle.lerp(labelError, other.labelError, t)!,
      labelSuccess: TextStyle.lerp(labelSuccess, other.labelSuccess, t)!,
      labelWarning: TextStyle.lerp(labelWarning, other.labelWarning, t)!,
      // Specialized Component Styles
      cardTitleStyle: TextStyle.lerp(cardTitleStyle, other.cardTitleStyle, t)!,
      cardSubtitleStyle: TextStyle.lerp(cardSubtitleStyle, other.cardSubtitleStyle, t)!,
      navigationLabel: TextStyle.lerp(navigationLabel, other.navigationLabel, t)!,
      tabLabel: TextStyle.lerp(tabLabel, other.tabLabel, t)!,
      breadcrumbStyle: TextStyle.lerp(breadcrumbStyle, other.breadcrumbStyle, t)!,
      timestampStyle: TextStyle.lerp(timestampStyle, other.timestampStyle, t)!,
      priceStyle: TextStyle.lerp(priceStyle, other.priceStyle, t)!,
      linkStyle: TextStyle.lerp(linkStyle, other.linkStyle, t)!,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
      placeholderStyle: TextStyle.lerp(placeholderStyle, other.placeholderStyle, t)!,
      tooltipStyle: TextStyle.lerp(tooltipStyle, other.tooltipStyle, t)!,
      badgeStyle: TextStyle.lerp(badgeStyle, other.badgeStyle, t)!,
      // Visual Elements
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