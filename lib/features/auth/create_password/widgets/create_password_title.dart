import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';

class CreatePasswordTitle extends StatelessWidget {
  const CreatePasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Créer votre mot de passe",
          style: AppTextStyles.headline2,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          "Cette étape permet de sécuriser votre compte.",
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
