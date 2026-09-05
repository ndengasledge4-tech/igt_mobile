import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class ActivationDescription extends StatelessWidget {
  const ActivationDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                "Comment activer votre compte ?",
                style: AppTextStyles.title,
              ),
            ],
          ),

          SizedBox(height: 16),

          Text(
            "Bienvenue sur l'application mobile de l'Institut de Gestion et de Technologie (IGT).\n\n"
            "Lors de votre première connexion, vous devez activer votre compte étudiant.\n\n"
            "Munissez-vous de :",
            style: AppTextStyles.body,
          ),

          SizedBox(height: 14),

          Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Votre matricule étudiant",
                  style: AppTextStyles.body,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Le code d'activation fourni par la scolarité",
                  style: AppTextStyles.body,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
