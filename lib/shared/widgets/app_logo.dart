import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 90,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Icon(
        Icons.school_rounded,
        size: 48,
        color: AppColors.primary,
      ),
    );
  }
}