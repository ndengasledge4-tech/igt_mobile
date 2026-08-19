import 'package:flutter/material.dart';

/// Compact institutional palette for IGT Mobile.
///
/// Widgets should normally read colors from [Theme.of] and [ColorScheme]. These
/// constants are reserved for theme construction, illustrations and semantic
/// states that are not represented by Material's color scheme.
abstract final class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF1C5D8F);
  static const Color primaryLight = Color(0xFF3C7EB1);
  static const Color primaryDark = Color(0xFF0E426A);
  static const Color secondary = Color(0xFF2A6F6B);
  static const Color accent = Color(0xFFC3913F);

  static const Color background = Color(0xFFF5F7FA);
  static const Color scaffold = background;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFEAF0F5);
  static const Color card = surface;
  static const Color white = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF0E151B);
  static const Color darkSurface = Color(0xFF151F27);
  static const Color darkSurfaceVariant = Color(0xFF1E2B35);

  static const Color textPrimary = Color(0xFF17232D);
  static const Color textSecondary = Color(0xFF5D6B78);
  static const Color textDisabled = Color(0xFF98A4AE);
  static const Color darkTextPrimary = Color(0xFFF2F5F7);
  static const Color darkTextSecondary = Color(0xFFAFBAC3);
  static const Color darkTextDisabled = Color(0xFF6F7C86);

  // Compatibility aliases for the screens that will be redesigned later.
  static const Color text = textPrimary;
  static const Color secondaryText = textSecondary;
  static const Color hint = textDisabled;
  static const Color softBlue = Color(0xFFE5EFF7);
  static const Color lightBlue = Color(0xFFF1F6FA);

  static const Color border = Color(0xFFD8E0E7);
  static const Color divider = Color(0xFFE5EBF0);
  static const Color darkBorder = Color(0xFF34434E);
  static const Color darkDivider = Color(0xFF273640);

<<<<<<< HEAD
  static const Color success = Color(0xFF27845B);
  static const Color warning = Color(0xFFB87512);
  static const Color error = Color(0xFFB94A4A);
  static const Color info = Color(0xFF3478A8);
=======
  // Bordures
  static const Color border = Color(0xFFE4E7EC);
  static const Color divider = Color(0xFFEEF2F6);

  // Etats
  static const Color success = Color(0xFF4CAF78);
  static const Color warning = Color(0xFFE9A23B);
  static const Color error = Color(0xFFD95C5C);

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
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
}
