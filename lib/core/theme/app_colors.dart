import 'package:flutter/material.dart';

/// Design tokens from design-system/MASTER.md ("Accessible & Ethical", WCAG-AAA).
/// Transit-blue palette. Never hardcode hex in widgets — reference these.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF2563EB);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF0891B2);
  static const accent = Color(0xFFEA580C);

  // Surfaces (light)
  static const background = Color(0xFFF8FAFC);
  static const foreground = Color(0xFF0F172A);
  static const muted = Color(0xFFF1F5FD);
  static const border = Color(0xFFE4ECFC);

  // Status
  static const destructive = Color(0xFFDC2626);
  static const ring = Color(0xFF2563EB);

  // Dark surfaces (desaturated tonal, not inverted)
  static const backgroundDark = Color(0xFF0B1220);
  static const foregroundDark = Color(0xFFE2E8F0);
  static const mutedDark = Color(0xFF1E293B);
  static const borderDark = Color(0xFF334155);

  // Bus status (always pair with icon + label — never color-only)
  static const statusRunning = Color(0xFF16A34A);
  static const statusIdle = Color(0xFFCA8A04);
  static const statusStopped = Color(0xFFDC2626);
  static const statusNoData = Color(0xFF64748B);
}
