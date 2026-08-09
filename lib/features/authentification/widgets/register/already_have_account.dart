import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../app/routes/route_names.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          "Vous avez déjà un compte ?",
          style: AppTextStyles.bodySmall,
        ),

        TextButton(
          onPressed: () {
            Navigator.pop(context);

            // ou

            // Navigator.pushReplacementNamed(
            //   context,
            //   RouteNames.login,
            // );
          },
          child: const Text(
            "Connexion",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}