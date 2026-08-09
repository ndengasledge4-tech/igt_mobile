import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Créer un compte",
          style: AppTextStyles.headline2,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        Text(
          "Complétez les informations ci-dessous pour créer votre compte étudiant IGT.",
          style: AppTextStyles.body.copyWith(
            color: AppColors.secondaryText,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}