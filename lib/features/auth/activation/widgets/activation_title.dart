import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';

class ActivationTitle extends StatelessWidget {
  const ActivationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Activation du compte",
          style: AppTextStyles.headline2,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          "Première connexion à l'application IGT",
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}