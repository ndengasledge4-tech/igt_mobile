import 'package:flutter/material.dart';

abstract final class AppColors {
  const AppColors._();

  // Couleur principale
  static const Color primary = Color(0xFF4F7CAC);

  // Variantes
  static const Color primaryLight = Color(0xFF7EA1C4);
  static const Color primaryDark = Color(0xFF2F5D8A);

  // Background
  static const Color background = Color(0xFFF7F9FC);
  static const Color scaffold = Color(0xFFF7F9FC);

  // Surfaces
  static const Color card = Colors.white;
  static const Color white = Colors.white;

  // Couleurs secondaires
  static const Color softBlue = Color(0xFFEAF2F8);
  static const Color lightBlue = Color(0xFFF5F9FC);

  // Texte
  static const Color text = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF667085);
  static const Color hint = Color(0xFF98A2B3);

  // Bordures
  static const Color border = Color(0xFFE4E7EC);
  static const Color divider = Color(0xFFEEF2F6);

  // Etats
  static const Color success = Color(0xFF4CAF78);
  static const Color warning = Color(0xFFE9A23B);
  static const Color error = Color(0xFFD95C5C);
}
