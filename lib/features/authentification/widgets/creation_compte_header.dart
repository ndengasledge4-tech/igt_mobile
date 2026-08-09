import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class CreationCompteHeader extends StatelessWidget {
  const CreationCompteHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Créer un compte',
          style: AppTextStyles.headline1,
        ),

        const SizedBox(height: 8),

        Text(
          'Complétez les informations ci-dessous pour créer votre compte étudiant IGT.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.softBlue,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.primary,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  'Renseignez les informations correspondant à votre dossier étudiant.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}