import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'aty_semantic_colors.dart';

abstract final class AtyTheme {
  static const semanticLight = AtySemanticColors(
    like: Color(0xFFE63960),
    trending: Color(0xFF9A6B00),
    highlight: Color(0xFF006F78),
  );

  static const semanticDark = AtySemanticColors(
    like: Color(0xFFFF8299),
    trending: Color(0xFFFFC24C),
    highlight: Color(0xFF65E0E9),
  );

  static ThemeData light() => _theme(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF9F2442),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFF8DCE4),
          onPrimaryContainer: Color(0xFF571126),
          secondary: Color(0xFF005C6D),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFC5EDF1),
          onSecondaryContainer: Color(0xFF003D48),
          tertiary: Color(0xFF006F78),
          onTertiary: Color(0xFFFFFFFF),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF202124),
          surfaceContainerLow: Color(0xFFF8F8F8),
          surfaceContainer: Color(0xFFF1F3F4),
          outlineVariant: Color(0xFFDADADA),
        ),
        semanticColors: semanticLight,
      );

  static ThemeData dark() => _theme(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF0A5B8),
          onPrimary: Color(0xFF56172B),
          primaryContainer: Color(0xFF79233D),
          onPrimaryContainer: Color(0xFFFFD9E4),
          secondary: Color(0xFF78D3DF),
          onSecondary: Color(0xFF00363F),
          secondaryContainer: Color(0xFF164D57),
          onSecondaryContainer: Color(0xFFB9EDF2),
          tertiary: Color(0xFF65E0E9),
          onTertiary: Color(0xFF00373C),
          surface: Color(0xFF151A1D),
          onSurface: Color(0xFFE7E9EA),
          surfaceContainerLow: Color(0xFF1D2428),
          surfaceContainer: Color(0xFF252D31),
          outlineVariant: Color(0xFF414B50),
        ),
        semanticColors: semanticDark,
      );

  static ThemeData _theme({
    required ColorScheme colorScheme,
    required AtySemanticColors semanticColors,
  }) {
    final base = ThemeData(colorScheme: colorScheme).textTheme.apply(
          fontFamily: GoogleFonts.inter().fontFamily,
        );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: base.copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          textStyle: base.displayLarge,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          textStyle: base.displayMedium,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          textStyle: base.headlineLarge,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          textStyle: base.headlineMedium,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          textStyle: base.titleLarge,
          fontWeight: FontWeight.w600,
        ),
      ),
      extensions: [semanticColors],
    );
  }
}
