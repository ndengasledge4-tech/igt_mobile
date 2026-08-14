import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import 'notification_button.dart';
import 'profil_etudiant_card.dart';

class AccueilHeader extends StatelessWidget {
  const AccueilHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.md,
        AppDimensions.md,
        AppDimensions.md,
        AppDimensions.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            AppDimensions.radiusLarge,
          ),
          bottomRight: Radius.circular(
            AppDimensions.radiusLarge,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bonjour 👋',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(
                      height: AppDimensions.xs,
                    ),
                    Text(
                      'Jean DUPONT',
                      style: AppTextStyles.title.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const NotificationButton(),
            ],
          ),

          const SizedBox(
            height: AppDimensions.md,
          ),

          const ProfilEtudiantCard(),
        ],
      ),
    );
  }
}