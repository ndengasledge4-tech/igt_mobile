import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class PasswordSuccessCard extends StatelessWidget {
  const PasswordSuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 55,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Compte activé !",
            style: AppTextStyles.headline2,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          const Text(
            "Votre mot de passe a été créé avec succès.\n\n"
            "Vous pouvez maintenant vous connecter à votre espace étudiant.",
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.login,
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Se connecter",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
