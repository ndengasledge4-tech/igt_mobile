import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        children: [
          Icon(Icons.support_agent_rounded, size: 40, color: AppColors.primary),

          SizedBox(height: 12),

          Text(
            "Besoin d'aide ?",
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          Text(
            "Si vous n'avez pas reçu votre code d'activation ou si vous rencontrez un problème lors de l'activation de votre compte, veuillez contacter le service de la scolarité de l'Institut de Gestion et de Technologie (IGT).",
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email_outlined, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text("scolarite@igt.edu.cd", style: AppTextStyles.body),
            ],
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_outlined, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text("+242 00 000 0000", style: AppTextStyles.body),
            ],
          ),
        ],
      ),
    );
  }
}
