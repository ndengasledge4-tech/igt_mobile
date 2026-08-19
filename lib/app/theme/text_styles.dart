import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  const AppTextStyles._();

<<<<<<< HEAD
  static const TextStyle display = TextStyle(
    fontSize: 34,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
  );
  static const TextStyle headline = TextStyle(
    fontSize: 28,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 22,
    height: 1.25,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle titleLarge = TextStyle(
=======
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
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );
<<<<<<< HEAD
=======

  /// Titre de carte
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
  static const TextStyle title = TextStyle(
    fontSize: 17,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );
<<<<<<< HEAD
  static const TextStyle titleSmall = TextStyle(
    fontSize: 15,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle body = TextStyle(fontSize: 16, height: 1.5);
  static const TextStyle bodySmall = TextStyle(fontSize: 14, height: 1.45);
  static const TextStyle label = TextStyle(
    fontSize: 14,
    height: 1.25,
=======

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
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
    fontWeight: FontWeight.w600,
  );
<<<<<<< HEAD
  static const TextStyle caption = TextStyle(fontSize: 12, height: 1.35);
  static const TextStyle button = label;

  // Compatibility aliases for the first generation of screens.
  static const TextStyle headline1 = display;
  static const TextStyle headline2 = headline;
  static const TextStyle headline3 = headlineSmall;
=======

  /// Labels des champs
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
}
