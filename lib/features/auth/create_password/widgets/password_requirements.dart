import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key});

  Widget item(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.success,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.bodySmall)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Votre mot de passe doit contenir :",
            style: AppTextStyles.title,
          ),
          const SizedBox(height: 16),
          item("Au moins 8 caractères"),
          item("Une lettre majuscule"),
          item("Une lettre minuscule"),
          item("Un chiffre"),
          item("Un caractère spécial"),
        ],
      ),
    );
  }
}
