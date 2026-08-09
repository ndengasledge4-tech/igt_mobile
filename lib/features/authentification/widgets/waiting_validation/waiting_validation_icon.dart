import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

class WaitingValidationIcon extends StatelessWidget {
  const WaitingValidationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.mark_email_read_rounded,
        color: AppColors.success,
        size: 70,
      ),
    );
  }
}