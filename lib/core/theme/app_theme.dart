import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// App theme built from design-system/MASTER.md.
/// Headings: Lexend · Body: Source Sans 3 · base 16px · 8dp rhythm.
abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accent,
      error: AppColors.destructive,
      surface: isDark ? AppColors.backgroundDark : AppColors.background,
      onSurface: isDark ? AppColors.foregroundDark : AppColors.foreground,
      outline: isDark ? AppColors.borderDark : AppColors.border,
    );

    final baseText = isDark ? AppColors.foregroundDark : AppColors.foreground;

    // Lexend for display/headline/title, Source Sans 3 for body/label.
    final textTheme = TextTheme(
      displayLarge: GoogleFonts.lexend(fontSize: 32, fontWeight: FontWeight.w700, color: baseText),
      headlineMedium: GoogleFonts.lexend(fontSize: 24, fontWeight: FontWeight.w600, color: baseText),
      titleLarge: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.w600, color: baseText),
      titleMedium: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.w500, color: baseText),
      bodyLarge: GoogleFonts.sourceSans3(fontSize: 16, height: 1.5, color: baseText),
      bodyMedium: GoogleFonts.sourceSans3(fontSize: 14, height: 1.5, color: baseText),
      labelLarge: GoogleFonts.sourceSans3(fontSize: 14, fontWeight: FontWeight.w500, color: baseText),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      visualDensity: VisualDensity.standard,
      // Anti-pattern guard: avoid heavy shadows.
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? AppColors.mutedDark : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      // Focus ring 3px for keyboard a11y.
      focusColor: AppColors.ring.withValues(alpha: 0.4),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 48), // ≥44 touch target
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.mutedDark : AppColors.muted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.ring, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark ? AppColors.mutedDark : Colors.white,
        indicatorColor: AppColors.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
