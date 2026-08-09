import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 12),
        child: Text(
          "En vous connectant, vous acceptez les\nconditions d'utilisation de l'application.",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall,
        ),
      ),
    );
  }
}