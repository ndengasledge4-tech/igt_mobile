import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  const AppTextStyles._();

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
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle title = TextStyle(
    fontSize: 17,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 15,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    height: 1.4,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body = TextStyle(fontSize: 16, height: 1.5);
  static const TextStyle bodySmall = TextStyle(fontSize: 14, height: 1.45);

  static const TextStyle label = TextStyle(
    fontSize: 14,
    height: 1.25,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption = TextStyle(fontSize: 12, height: 1.35);
  static const TextStyle button = label;

  // Compatibility aliases used by the first generation of screens.
  static const TextStyle headline1 = display;
  static const TextStyle headline2 = headline;
  static const TextStyle headline3 = headlineSmall;
}
