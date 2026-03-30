import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'typography.dart';
import 'components.dart';
import 'elevation.dart';
import 'editorial_theme_data.dart';

// Re-export for convenience
export 'editorial_theme_data.dart';

/// The Editorial Concierge Light Theme
/// A premium wedding venue management system theme that feels like a digital atelier
ThemeData get editorialLightTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  
  // Color scheme
  colorScheme: lightEditorialColorScheme,
  
  // Typography
  textTheme: editorialLightTextTheme,
  
  // Component themes following "No-Line" rule and luxury aesthetic
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: EditorialComponents.primaryButton(lightEditorialColorScheme),
  ),
  
  textButtonTheme: TextButtonThemeData(
    style: EditorialComponents.tertiaryButton(lightEditorialColorScheme),
  ),
  
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: EditorialComponents.secondaryButton(lightEditorialColorScheme),
  ),
  
  cardTheme: EditorialComponents.cardTheme(lightEditorialColorScheme),
  
  inputDecorationTheme: EditorialComponents.inputDecorationTheme(lightEditorialColorScheme),
  
  listTileTheme: EditorialComponents.listTileTheme(lightEditorialColorScheme),
  
  appBarTheme: EditorialComponents.appBarTheme(lightEditorialColorScheme),
  
  chipTheme: EditorialComponents.chipTheme(lightEditorialColorScheme),
  
  // Disable divider theme - following "No-Line" rule
  dividerTheme: const DividerThemeData(
    thickness: 0,
    space: 0,
    color: Colors.transparent,
  ),
  
  // Scaffold background
  scaffoldBackgroundColor: lightEditorialColorScheme.surface,
  
  // Visual density for premium feel
  visualDensity: VisualDensity.standard,
  
  // Material state colors
  splashColor: lightEditorialColorScheme.primary.withOpacity(0.08),
  highlightColor: lightEditorialColorScheme.primary.withOpacity(0.04),
  focusColor: lightEditorialColorScheme.primary.withOpacity(0.12),
  hoverColor: lightEditorialColorScheme.primary.withOpacity(0.04),
  
  // Icon theme
  iconTheme: IconThemeData(
    color: lightEditorialColorScheme.onSurfaceVariant,
    size: 24,
  ),
  
  // Bottom navigation
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightEditorialColorScheme.surface,
    selectedItemColor: lightEditorialColorScheme.primary,
    unselectedItemColor: lightEditorialColorScheme.onSurfaceVariant,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
  ),
  
  // Floating action button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightEditorialColorScheme.primary,
    foregroundColor: lightEditorialColorScheme.onPrimary,
    elevation: EditorialElevation.level3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  
  // NavigationBar (Material 3)
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: lightEditorialColorScheme.surface,
    indicatorColor: lightEditorialColorScheme.primaryContainer,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return EditorialTypography.labelSmall(lightEditorialColorScheme)
            .copyWith(color: lightEditorialColorScheme.primary);
      }
      return EditorialTypography.labelSmall(lightEditorialColorScheme);
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: lightEditorialColorScheme.primary);
      }
      return IconThemeData(color: lightEditorialColorScheme.onSurfaceVariant);
    }),
  ),
  
  // Switch theme
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return lightEditorialColorScheme.primary;
      }
      return lightEditorialColorScheme.outline;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return lightEditorialColorScheme.primaryContainer;
      }
      return lightEditorialColorScheme.surfaceContainerHighest;
    }),
  ),
  
  // Custom editorial theme extension
  extensions: <ThemeExtension<dynamic>>[
    EditorialThemeData.light(),
  ],
).withNoLineRule;

/// The Editorial Concierge Dark Theme
/// Maintains the luxury aesthetic while providing dark mode comfort
ThemeData get editorialDarkTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  
  // Color scheme
  colorScheme: darkEditorialColorScheme,
  
  // Typography (same styles, different colors)
  textTheme: editorialDarkTextTheme,
  
  // Component themes adapted for dark mode
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: EditorialComponents.primaryButton(darkEditorialColorScheme),
  ),
  
  textButtonTheme: TextButtonThemeData(
    style: EditorialComponents.tertiaryButton(darkEditorialColorScheme),
  ),
  
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: EditorialComponents.secondaryButton(darkEditorialColorScheme),
  ),
  
  cardTheme: EditorialComponents.cardTheme(darkEditorialColorScheme),
  
  inputDecorationTheme: EditorialComponents.inputDecorationTheme(darkEditorialColorScheme),
  
  listTileTheme: EditorialComponents.listTileTheme(darkEditorialColorScheme),
  
  appBarTheme: EditorialComponents.appBarTheme(darkEditorialColorScheme),
  
  chipTheme: EditorialComponents.chipTheme(darkEditorialColorScheme),
  
  // Disable divider theme - following "No-Line" rule
  dividerTheme: const DividerThemeData(
    thickness: 0,
    space: 0,
    color: Colors.transparent,
  ),
  
  // Scaffold background
  scaffoldBackgroundColor: darkEditorialColorScheme.surface,
  
  // Visual density for premium feel
  visualDensity: VisualDensity.standard,
  
  // Material state colors
  splashColor: darkEditorialColorScheme.primary.withOpacity(0.08),
  highlightColor: darkEditorialColorScheme.primary.withOpacity(0.04),
  focusColor: darkEditorialColorScheme.primary.withOpacity(0.12),
  hoverColor: darkEditorialColorScheme.primary.withOpacity(0.04),
  
  // Icon theme
  iconTheme: IconThemeData(
    color: darkEditorialColorScheme.onSurfaceVariant,
    size: 24,
  ),
  
  // Bottom navigation
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkEditorialColorScheme.surface,
    selectedItemColor: darkEditorialColorScheme.primary,
    unselectedItemColor: darkEditorialColorScheme.onSurfaceVariant,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
  ),
  
  // Floating action button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkEditorialColorScheme.primary,
    foregroundColor: darkEditorialColorScheme.onPrimary,
    elevation: EditorialElevation.level3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  
  // NavigationBar (Material 3)
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: darkEditorialColorScheme.surface,
    indicatorColor: darkEditorialColorScheme.primaryContainer,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return EditorialTypography.labelSmall(darkEditorialColorScheme)
            .copyWith(color: darkEditorialColorScheme.primary);
      }
      return EditorialTypography.labelSmall(darkEditorialColorScheme);
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: darkEditorialColorScheme.primary);
      }
      return IconThemeData(color: darkEditorialColorScheme.onSurfaceVariant);
    }),
  ),
  
  // Switch theme
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return darkEditorialColorScheme.primary;
      }
      return darkEditorialColorScheme.outline;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return darkEditorialColorScheme.primaryContainer;
      }
      return darkEditorialColorScheme.surfaceContainerHighest;
    }),
  ),
  
  // Custom editorial theme extension
  extensions: <ThemeExtension<dynamic>>[
    EditorialThemeData.dark(),
  ],
).withNoLineRule;

/// Get theme based on brightness
ThemeData getEditorialTheme(Brightness brightness) {
  return brightness == Brightness.light ? editorialLightTheme : editorialDarkTheme;
}

/// System UI overlay styles for each theme
SystemUiOverlayStyle get lightSystemUiStyle => const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
);

SystemUiOverlayStyle get darkSystemUiStyle => const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
);

/// Get appropriate system UI style based on theme mode
SystemUiOverlayStyle getSystemUiStyle(ThemeMode themeMode) {
  return themeMode == ThemeMode.dark ? darkSystemUiStyle : lightSystemUiStyle;
}