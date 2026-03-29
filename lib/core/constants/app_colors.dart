import 'package:flutter/material.dart';

/// Single source of truth for all app colors.
/// To change the palette, only edit this file — nothing else needs to change.
abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF4361EE);
  static const Color primaryDark = Color(0xFF3651D4);
  static const Color secondary = Color(0xFF7B2FBE);
  static const Color accent = Color(0xFF06D6A0);

  // ── Light theme surfaces ───────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF8F9FE);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFEEF0FB);
  static const Color lightOnSurface = Color(0xFF1A1C2E);
  static const Color lightOnSurfaceVariant = Color(0xFF6B7080);

  // ── Dark theme surfaces ────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0D0F1A);
  static const Color darkSurface = Color(0xFF181A2E);
  static const Color darkSurfaceVariant = Color(0xFF1F2235);
  static const Color darkOnSurface = Color(0xFFE8EAFF);
  static const Color darkOnSurfaceVariant = Color(0xFF9EA3C0);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF06D6A0);
  static const Color error = Color(0xFFEF476F);
  static const Color warning = Color(0xFFFFB703);
  static const Color info = Color(0xFF118AB2);

  // ── Dividers ───────────────────────────────────────────────────────────────
  static const Color divider = Color(0xFFE0E3F0);
  static const Color dividerDark = Color(0xFF2A2D45);
}
