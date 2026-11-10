import 'package:flutter/material.dart';

@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  final Color textMain;
  final Color textMuted;
  final Color success;
  final Color warning;
  final Color info;
  final Color borderSubtle;

  const AppSemanticColors({
    required this.textMain,
    required this.textMuted,
    required this.success,
    required this.warning,
    required this.info,
    required this.borderSubtle,
  });

  @override
  AppSemanticColors copyWith({
    Color? textMain,
    Color? textMuted,
    Color? success,
    Color? warning,
    Color? info,
    Color? borderSubtle,
  }) {
    return AppSemanticColors(
      textMain: textMain ?? this.textMain,
      textMuted: textMuted ?? this.textMuted,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      borderSubtle: borderSubtle ?? this.borderSubtle,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
    );
  }
}

class AppTheme {
  // Brand colors from design.md
  static const _primary = Color(0xFF2E2A72); // Deep Navy Base
  static const _primaryContainer = Color(0xFFEEF0F2); // Faint Indigo Tint
  static const _secondary = Color(0xFF4F46E5); // Vibrant Indigo Action
  static const _secondaryContainer = Color(0xFFEEF2FF); // Soft Inactive Surface
  static const _tertiary = Color(0xFFD97706); // Professional Amber Accent
  static const _error = Color(0xFFEF4444);

  //Dark colors
  static const _primaryDark = Color(0xFF93C5FD); // Soft Sky Indigo
  static const _primaryContainerDark = Color(0xFF1E3A8A); // Deep Midnight Blue
  static const _secondaryDark = Color(0xFFC7D2FE); // Muted Lavender Gray
  static const _secondaryContainerDark = Color(
    0xFF312E81,
  ); // Low-Glow Deep Purple
  static const _tertiaryDark = Color(0xFFFBBF24); // Soft Amber Highlight
  static const _backgroundDark        = Color(0xFF0B0D12);
  static const _surfaceDark           = Color(0xFF0F121A);
  static const _surfaceContainerLowDark   = Color(0xFF161A24); // Shimmer Highlight
  static const _surfaceContainerDark      = Color(0xFF1D2230); // Shimmer Base Bone
  static const _surfaceContainerHighDark  = Color(0xFF252B3D);


  // Light Surfaces
  static const _backgroundLight = Color(0xFFF8F9FA);
  static const _surfaceLight = Color(0xFFF8F9FA);
  static const _surfaceContainerLowLight = Color(0xFFF1F3F5);
  static const _surfaceContainerLight = Color(0xFFE9ECEF);
  static const _surfaceContainerHighLight = Color(0xFFDEE2E6);

  // Dark Surfaces
  // static const _backgroundDark = Color(0xFF0F1115);
  // static const _surfaceDark = Color(0xFF161920);

  // Text/outline
  static const _onSurfaceLight = Color(0xFF191C1D);
  static const _onSurfaceDark = Color(0xFFE2E2E5);
  static const _onSurfaceVariantLight = Color(0xFF464555);
  static const _onSurfaceVariantDark = Color(0xFFC7C5D8);
  static const _outlineLight = Color(0xFF777587);
  static const _outlineDark = Color(0xFF918F9C);

  // Semantic extras (Light)
  static const _textMainLight = Color(0xFF111827);
  static const _textMutedLight = Color(0xFF6B7280);
  static const _successLight = Color(0xFF10B981);
  static const _warningLight = Color(0xFFF59E0B);
  static const _infoLight = Color(0xFF3B82F6);
  static const _borderSubtleLight = Color(0xFFE5E7EB);

  // Semantic extras (Dark)
  static const _textMainDark = Color(0xFFF9FAFB);
  static const _textMutedDark = Color(0xFF9CA3AF);
  static const _successDark = Color(0xFF34D399);
  static const _warningDark = Color(0xFFFBBF24);
  static const _infoDark = Color(0xFF60A5FA);
  static const _borderSubtleDark = Color(0xFF374151);

  static final ColorScheme _lightScheme = const ColorScheme(
    surfaceContainer: _surfaceContainerLight,
    surfaceContainerHigh: _surfaceContainerHighLight,
    surfaceContainerLow: _surfaceContainerLowLight,
    brightness: Brightness.light,
    primary: _primary,
    onPrimary: Colors.white,
    primaryContainer: _primaryContainer,
    onPrimaryContainer: Color(0xFFDAD7FF),
    secondary: _secondary,
    onSecondary: Colors.white,
    secondaryContainer: _secondaryContainer,
    onSecondaryContainer: Color(0xFFFFFBFF),
    tertiary: _tertiary,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFA44100),
    onTertiaryContainer: Color(0xFFFFD2BE),
    error: _error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    surface: _surfaceLight,
    onSurface: _onSurfaceLight,
    onSurfaceVariant: _onSurfaceVariantLight,
    outline: _outlineLight,
    outlineVariant: _borderSubtleLight,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFF2E3132),
    onInverseSurface: Color(0xFFF0F1F2),
    inversePrimary: Color(0xFFC3C0FF),
    surfaceTint: Colors.transparent, //Color(0xFF4D44E3),
  );

  static final ColorScheme _darkScheme = const ColorScheme(
    surfaceContainer: _surfaceContainerDark,
    surfaceContainerHigh: _surfaceContainerHighDark,
    surfaceContainerLow: _surfaceContainerLowDark,
    brightness: Brightness.dark,
    primary: _primaryDark,
    onPrimary: Colors.white,
    primaryContainer: _primaryContainerDark,
    onPrimaryContainer: Color(0xFFE0E0FF),
    secondary: _secondaryDark,
    onSecondary: Colors.white,
    secondaryContainer: _secondaryContainerDark,
    onSecondaryContainer: Color(0xFFFFFBFF),
    tertiary: _tertiaryDark,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFA44100),
    onTertiaryContainer: Color(0xFFFFD2BE),
    error: _error,
    onError: Colors.white,
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: _surfaceDark,
    onSurface: _onSurfaceDark,
    onSurfaceVariant: _onSurfaceVariantDark,
    outline: _outlineDark,
    outlineVariant: _borderSubtleDark,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFF0F1F2),
    onInverseSurface: Color(0xFF2E3132),
    inversePrimary: _primary,
    surfaceTint: Color(0xFF4D44E3),
  );

  static ThemeData get light => _buildTheme(
    _lightScheme,
    _backgroundLight,
    const AppSemanticColors(
      textMain: _textMainLight,
      textMuted: _textMutedLight,
      success: _successLight,
      warning: _warningLight,
      info: _infoLight,
      borderSubtle: _borderSubtleLight,
    ),
  );

  static ThemeData get dark => _buildTheme(
    _darkScheme,
    _backgroundDark,
    const AppSemanticColors(
      textMain: _textMainDark,
      textMuted: _textMutedDark,
      success: _successDark,
      warning: _warningDark,
      info: _infoDark,
      borderSubtle: _borderSubtleDark,
    ),
  );

  static ThemeData _buildTheme(
    ColorScheme s,
    Color bg,
    AppSemanticColors extension,
  ) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: s,
      scaffoldBackgroundColor: bg,
      fontFamily: 'Inter',
      extensions: [extension],

      dialogTheme: DialogThemeData(
        surfaceTintColor: Colors.transparent, // Blocks the blue elevation tint overlay
        backgroundColor: _primaryContainer,
        elevation: 2// Forces your exact clean surface background
      ),

      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: s.surface,
        foregroundColor: extension.textMain,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: extension.textMain,
        ),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.25,
          letterSpacing: -0.64,
          color: extension.textMain,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.333,
          letterSpacing: -0.24,
          color: extension.textMain,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: extension.textMain,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: extension.textMain,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.428,
          color: extension.textMain,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          height: 1.384,
          color: extension.textMain,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.333,
          letterSpacing: 0.6,
          color: extension.textMuted,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.273,
          color: extension.textMuted,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: s.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: extension.borderSubtle, width: 1),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: s.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.273,
          color: extension.textMuted,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: extension.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: extension.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: s.primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: s.error),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          backgroundColor: s.primary,
          foregroundColor: s.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          foregroundColor: s.brightness == Brightness.light
              ? s.primary
              : extension.textMain,
          side: BorderSide(color: extension.borderSubtle, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
