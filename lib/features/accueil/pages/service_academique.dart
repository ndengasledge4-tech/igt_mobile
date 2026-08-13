import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ServiceAcademiquePage extends StatelessWidget {
  const ServiceAcademiquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: AppDimensions.appBarHeight,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerCard(),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Information récente',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _informationCard(),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Services académiques',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _serviceItem(
              Icons.menu_book_outlined,
              'Mes cours',
              'Consulter la liste de vos cours.',
            ),

            _serviceItem(
              Icons.grade_outlined,
              'Mes notes',
              'Consulter vos résultats et vos notes.',
            ),

            _serviceItem(
              Icons.bar_chart_outlined,
              'Résultats',
              'Consulter votre moyenne et vos crédits.',
            ),

            _serviceItem(
              Icons.calendar_today_outlined,
              'Emploi du temps',
              'Consulter votre programme académique.',
            ),

            _serviceItem(
              Icons.assignment_outlined,
              'Examens',
              'Consulter les informations relatives aux examens.',
            ),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Contact',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _contactCard(),

            const SizedBox(height: AppDimensions.xl),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.lg),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusMedium,
              ),
            ),
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: AppDimensions.iconLarge,
            ),
          ),

          const SizedBox(height: AppDimensions.md),

          Text(
            'Service académique',
            style: AppTextStyles.headline3.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: AppDimensions.sm),

          Text(
            'Accédez aux informations concernant votre parcours académique.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.md),
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            child: const Icon(
              Icons.info_outline,
              color: AppColors.primary,
              size: AppDimensions.iconMedium,
            ),
          ),

          const SizedBox(width: AppDimensions.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nouvelle information disponible',
                  style: AppTextStyles.title.copyWith(
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: AppDimensions.xs),

                Text(
                  'Une nouvelle information concernant les activités académiques est disponible.',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceItem(
      IconData icon,
      String title,
      String description,
      ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: AppDimensions.sm,
      ),
      padding: const EdgeInsets.all(AppDimensions.md),
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: AppDimensions.iconMedium,
            ),
          ),

          const SizedBox(width: AppDimensions.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: AppDimensions.xs),

                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),

          const SizedBox(width: AppDimensions.sm),

          const Icon(
            Icons.chevron_right,
            color: AppColors.hint,
            size: AppDimensions.iconMedium,
          ),
        ],
      ),
    );
  }

  Widget _contactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service académique',
            style: AppTextStyles.title.copyWith(
              fontSize: 15,
            ),
          ),

          const SizedBox(height: AppDimensions.sm),

          Text(
            'Téléphone : +242 06 000 00 00',
            style: AppTextStyles.bodySmall,
          ),

          const SizedBox(height: AppDimensions.xs),

          Text(
            'Email : academique@universite.com',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}