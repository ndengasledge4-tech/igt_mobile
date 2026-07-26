import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class NotificationEmpty extends StatelessWidget {
  const NotificationEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 90,
              color: AppColors.hint,
            ),

            const SizedBox(height: 24),

            const Text(
              "Aucune notification",
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: 10),

            const Text(
              "Vous êtes à jour.\nLes nouvelles notifications apparaîtront ici.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}