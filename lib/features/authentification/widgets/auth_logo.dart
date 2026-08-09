import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({
    super.key,
    this.size = 86,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.18),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Image.asset(
        'assets/logo/logo.png',
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) {
          return Icon(
            Icons.school_rounded,
            size: size * 0.5,
            color: AppColors.primary,
          );
        },
      ),
    );
  }
}