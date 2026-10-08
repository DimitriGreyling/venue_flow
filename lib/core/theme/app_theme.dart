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
  static const _primary = Color(0xFF3525CD);
  static const _primaryContainer = Color(0xFF4F46E5);
  static const _secondary = Color(0xFF4442E3);
  static const _secondaryContainer = Color(0xFF5F5FFD);
  static const _tertiary = Color(0xFF7E3000);
  static const _error = Color(0xFFEF4444);

  // Surfaces
  static const _background = Color(0xFFF8F9FA);
  static const _surface = Color(0xFFF8F9FA);
  static const _surfaceContainerLow = Color(0xFFF3F4F5);
  static const _surfaceContainer = Color(0xFFEDEEEF);

  // Text/outline
  static const _onSurface = Color(0xFF191C1D);
  static const _onSurfaceVariant = Color(0xFF464555);
  static const _outline = Color(0xFF777587);
  static const _outlineVariant = Color(0xFFC7C4D8);

  // Semantic extras
  static const _textMain = Color(0xFF111827);
  static const _textMuted = Color(0xFF6B7280);
  static const _success = Color(0xFF10B981);
  static const _warning = Color(0xFFF59E0B);
  static const _info = Color(0xFF3B82F6);
  static const _borderSubtle = Color(0xFFE5E7EB);

  static ColorScheme _lightScheme = const ColorScheme(
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
    surface: _surface,
    onSurface: _onSurface,
    onSurfaceVariant: _onSurfaceVariant,
    outline: _outline,
    outlineVariant: _outlineVariant,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFF2E3132),
    onInverseSurface: Color(0xFFF0F1F2),
    inversePrimary: Color(0xFFC3C0FF),
    surfaceTint: Color(0xFF4D44E3),
  );

  static ThemeData get light {
    final s = _lightScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: s,
      scaffoldBackgroundColor: _background,
      fontFamily: 'Inter',
      extensions: const [
        AppSemanticColors(
          textMain: _textMain,
          textMuted: _textMuted,
          success: _success,
          warning: _warning,
          info: _info,
          borderSubtle: _borderSubtle,
        ),
      ],

      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: s.surface,
        foregroundColor: _textMain,
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          // headline-md-ish desktop
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: _textMain,
        ),
      ),

      // Typography mapped from design.md
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.25,
          // 40/32
          letterSpacing: -0.64,
          // -0.02em * 32
          color: _textMain,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.333,
          // 32/24
          letterSpacing: -0.24,
          color: _textMain,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.4,
          // 28/20
          color: _textMain,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          // 24/16
          color: _textMain,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.428,
          // 20/14
          color: _textMain,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          height: 1.384,
          // 18/13
          color: _textMain,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.333,
          // 16/12
          letterSpacing: 0.6,
          // 0.05em * 12
          color: _textMuted,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.273,
          // 14/11
          color: _textMuted,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // default rounded
          side: const BorderSide(color: _borderSubtle, width: 1),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.273,
          color: _textMuted,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _borderSubtle),
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
          foregroundColor: s.primary,
          side: BorderSide(color: s.primary.withValues(alpha: 0.35)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide.none,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        backgroundColor: _surfaceContainer,
        selectedColor: s.primaryContainer.withValues(alpha: 0.18),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: _textMain,
        unselectedLabelColor: _textMuted,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: s.primary, width: 2),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),

      dividerTheme: const DividerThemeData(
        color: _borderSubtle,
        thickness: 1,
        space: 1,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: s.inverseSurface,
        contentTextStyle: TextStyle(color: s.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: s.primary,
        foregroundColor: s.onPrimary,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: s.primary),
    );
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,

      // Brand
      primary: Color(0xFFC0C1FF),
      onPrimary: Color(0xFF1000A9),
      primaryContainer: Color(0xFF8083FF),
      onPrimaryContainer: Color(0xFF0D0096),

      secondary: Color(0xFFC3C0FF),
      onSecondary: Color(0xFF1D00A5),
      secondaryContainer: Color(0xFF3626CE),
      onSecondaryContainer: Color(0xFFB3B1FF),

      tertiary: Color(0xFF7BD0FF),
      onTertiary: Color(0xFF00354A),
      tertiaryContainer: Color(0xFF009BD1),
      onTertiaryContainer: Color(0xFF002D40),

      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      // Surfaces
      surface: Color(0xFF0B1326),
      onSurface: Color(0xFFDAE2FD),
      onSurfaceVariant: Color(0xFFC7C4D7),

      outline: Color(0xFF908FA0),
      outlineVariant: Color(0xFF464554),

      inverseSurface: Color(0xFFDAE2FD),
      onInverseSurface: Color(0xFF283044),
      inversePrimary: Color(0xFF494BD6),

      shadow: Colors.black,
      scrim: Colors.black,
      surfaceTint: Color(0xFFC0C1FF),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      fontFamily: 'Inter',

      // Keep your extension if you already added it
      extensions: const [
        AppSemanticColors(
          textMain: Color(0xFFF8FAFC),
          textMuted: Color(0xFF94A3B8),
          success: Color(0xFF10B981),
          warning: Color(0xFFF59E0B),
          info: Color(0xFF38BDF8),
          borderSubtle: Color(0xFF334155),
        ),
      ],

      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xFF0B1326),
        foregroundColor: Color(0xFFF8FAFC),
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: Color(0xFFF8FAFC),
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F172A),
        // recessed input
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          color: Color(0xFF64748B),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.27,
          color: Color(0xFF94A3B8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFF43F5E)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFF43F5E), width: 1.2),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          backgroundColor: const Color(0xFF6366F1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // "Secondary button" style from your spec
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          backgroundColor: const Color(0xFF1E293B),
          foregroundColor: const Color(0xFFF8FAFC),
          side: const BorderSide(color: Color(0xFF334155)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide.none,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFFF8FAFC),
        ),
        backgroundColor: const Color(0xFF334155),
        selectedColor: const Color(0xFF243144),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected))
            return const Color(0xFF6366F1);
          return const Color(0xFF0F172A);
        }),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        side: const BorderSide(color: Color(0xFF334155)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      radioTheme: const RadioThemeData(
        fillColor: WidgetStatePropertyAll(Color(0xFF6366F1)),
      ),

      dividerTheme: const DividerThemeData(
        color: Color(0xFF334155),
        thickness: 1,
        space: 1,
      ),

      tabBarTheme: const TabBarThemeData(
        labelColor: Color(0xFFF8FAFC),
        unselectedLabelColor: Color(0xFF94A3B8),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1E293B),
        contentTextStyle: const TextStyle(color: Color(0xFFF8FAFC)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF6366F1),
        foregroundColor: Colors.white,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF6366F1),
      ),
    );
  }
}
