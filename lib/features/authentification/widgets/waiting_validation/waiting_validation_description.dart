import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class WaitingValidationDescription extends StatelessWidget {
  const WaitingValidationDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Votre demande de création de compte a bien été envoyée.\n\n"
          "Elle sera vérifiée par l'administration de l'IGT.\n\n"
          "Vous recevrez une notification dès que votre compte sera validé.",
      textAlign: TextAlign.center,
      style: AppTextStyles.body.copyWith(
        color: AppColors.secondaryText,
        height: 1.6,
      ),
    );
  }
}