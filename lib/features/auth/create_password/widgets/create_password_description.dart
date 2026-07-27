import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class CreatePasswordDescription extends StatelessWidget {
  const CreatePasswordDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Text(
        "Votre identité a été vérifiée avec succès.\n\n"
            "Choisissez maintenant un mot de passe sécurisé que vous utiliserez pour vous connecter à votre espace étudiant.",
        style: AppTextStyles.body,
        textAlign: TextAlign.center,
      ),
    );
  }
}