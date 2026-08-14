import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ActualitesPreview extends StatelessWidget {
  final VoidCallback onFirstPressed;
  final VoidCallback onSecondPressed;

  const ActualitesPreview({
    super.key,
    required this.onFirstPressed,
    required this.onSecondPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewsCard(
          icon: Icons.article_outlined,
          title: 'Inscription aux examens',
          category: 'Académique',
          date: 'Il y a 2h',
          onPressed: onFirstPressed,
        ),
        NewsCard(
          icon: Icons.event_available_outlined,
          title: 'Journée portes ouvertes',
          category: 'Événement',
          date: 'Hier',
          onPressed: onSecondPressed,
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String category;
  final String date;
  final VoidCallback onPressed;

  const NewsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.category,
    required this.date,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.xs,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        child: Container(
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
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 24,
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
                      title,
                      style: AppTextStyles.title.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      height: AppDimensions.xs,
                    ),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softBlue,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Text(
                            category,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: AppDimensions.xs,
                        ),

                        Text(
                          date,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: AppColors.hint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}