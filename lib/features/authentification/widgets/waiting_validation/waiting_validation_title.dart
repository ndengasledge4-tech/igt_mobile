import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';

class WaitingValidationTitle extends StatelessWidget {
  const WaitingValidationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Demande envoyée",
      textAlign: TextAlign.center,
      style: AppTextStyles.headline2,
    );
  }
}