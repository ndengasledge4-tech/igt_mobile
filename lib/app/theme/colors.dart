import 'package:flutter/material.dart';

/// Compact institutional palette for IGT Mobile.
///
/// Widgets should normally read colors from [Theme.of] and [ColorScheme]. These
/// constants are reserved for theme construction, illustrations and semantic
/// states that are not represented by Material's color scheme.
abstract final class AppColors {
  const AppColors._();

  static const Color primaryStrong = Color(0xFF0B2942);
  static const Color primary = Color(0xFF143D5D);
  static const Color primaryLight = Color(0xFF2B668E);
  static const Color primaryDark = primaryStrong;
  static const Color primarySoft = Color(0xFFE8F0F6);
  static const Color secondary = Color(0xFF2F7D78);
  static const Color secondarySoft = Color(0xFFE7F3F1);
  static const Color accent = Color(0xFFC79A45);

  static const Color background = Color(0xFFF5F7FA);
  static const Color scaffold = background;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFEDF2F6);
  static const Color card = surface;
  static const Color white = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF08111F);
  static const Color darkSurface = Color(0xFF0F1B2D);
  static const Color darkSurfaceVariant = Color(0xFF14243A);
  static const Color darkSurfaceElevated = Color(0xFF182A42);

  static const Color textPrimary = Color(0xFF172033);
  static const Color textSecondary = Color(0xFF667085);
  static const Color textDisabled = Color(0xFF98A2B3);
  static const Color darkTextPrimary = Color(0xFFF5F7FA);
  static const Color darkTextSecondary = Color(0xFFA9B5C5);
  static const Color darkTextDisabled = Color(0xFF77869B);

  // Compatibility aliases for the screens that will be redesigned later.
  static const Color text = textPrimary;
  static const Color secondaryText = textSecondary;
  static const Color hint = textDisabled;
  static const Color softBlue = primarySoft;
  static const Color lightBlue = Color(0xFFF1F5F8);

  static const Color border = Color(0xFFDDE5EC);
  static const Color divider = Color(0xFFE5EBF0);
  static const Color darkBorder = Color(0xFF263A52);
  static const Color darkDivider = Color(0xFF20334A);

  static const Color success = Color(0xFF27845B);
  static const Color warning = Color(0xFFB87512);
  static const Color error = Color(0xFFB94A4A);
  static const Color info = Color(0xFF3478A8);

  // Module Actualite
  static const Color actualiteHeader = Color(0xFF3F8DCD);
  static const Color actualiteBackground = Color(0xFFF4F7FB);
  static const Color actualiteCardBorder = Color(0xFFDCE6F1);
  static const Color actualiteText = Color(0xFF2D3D55);
  static const Color actualiteMutedText = Color(0xFF7890AA);
  static const Color actualiteSoftBlue = Color(0xFFEAF6FF);
  static const Color actualiteSoftRed = Color(0xFFFFECEC);
  static const Color actualiteSoftGreen = Color(0xFFEFF9F0);
  static const Color actualiteSoftYellow = Color(0xFFFFF3DC);
}
