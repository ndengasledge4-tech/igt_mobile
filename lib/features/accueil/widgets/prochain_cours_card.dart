import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ProchainCoursCard extends StatelessWidget {
  const ProchainCoursCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          AppDimensions.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.softBlue,
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusSmall,
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.primary,
                size: 25,
              ),
            ),

            const SizedBox(
              width: AppDimensions.sm,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PROCHAIN COURS • Aujourd'hui",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: AppDimensions.xs,
                  ),

                  Text(
                    'Algorithmique avancée',
                    style: AppTextStyles.title.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: AppDimensions.xs,
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        size: 17,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '08h00 – 10h00',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(
                        width: AppDimensions.sm,
                      ),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Salle A204',
                          style: AppTextStyles.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppDimensions.xs,
                  ),

                  Text(
                    'Prof. Mahamadou COULIBALY',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}