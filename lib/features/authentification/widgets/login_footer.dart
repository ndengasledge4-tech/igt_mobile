import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.motDePasseOublie,
              );
            },
            child: const Text(
              'Mot de passe oublié ?',
            ),
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.border,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                'ou',
                style: AppTextStyles.caption,
              ),
            ),

            const Expanded(
              child: Divider(
                color: AppColors.border,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouteNames.creationCompte,
            );
          },
          child: const Text(
            'Créer un compte',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}