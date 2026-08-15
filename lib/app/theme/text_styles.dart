import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppTextStyles {
  const AppTextStyles._();

  /// Grand titre (Splash, Login...)
  static const TextStyle headline1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  /// Titre principal des pages
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  /// Sous-titre
  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  /// Titre de carte
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  /// Sous-titre léger
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  /// Texte principal
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.text,
    height: 1.5,
  );

  /// Petit texte
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: AppColors.secondaryText,
    height: 1.4,
  );

  /// Légende
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.secondaryText,
  );

  /// Texte des boutons
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  /// Labels des champs
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
}
