import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class SecretariatPage extends StatelessWidget {
  const SecretariatPage({super.key});

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
              'Message récent',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _messageCard(),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Services disponibles',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _serviceItem(
              Icons.description_outlined,
              'Documents administratifs',
              'Demande et retrait de documents.',
            ),

            _serviceItem(
              Icons.assignment_outlined,
              'Dossiers étudiants',
              'Suivi de votre dossier académique.',
            ),

            _serviceItem(
              Icons.calendar_month_outlined,
              'Rendez-vous',
              'Prendre rendez-vous avec le secrétariat.',
            ),

            _serviceItem(
              Icons.info_outline,
              'Informations',
              'Consulter les annonces du secrétariat.',
            ),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Horaires',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            Container(
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
              child: const Column(
                children: [
                  _ScheduleRow(
                    day: 'Lundi - Vendredi',
                    hours: '08h00 - 16h00',
                  ),

                  SizedBox(height: AppDimensions.sm),

                  _ScheduleRow(
                    day: 'Samedi',
                    hours: '08h00 - 12h00',
                  ),
                ],
              ),
            ),

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
              Icons.support_agent_outlined,
              color: Colors.white,
              size: AppDimensions.iconLarge,
            ),
          ),

          const SizedBox(height: AppDimensions.md),

          Text(
            'Secrétariat',
            style: AppTextStyles.headline3.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: AppDimensions.sm),

          Text(
            'Retrouvez les informations et services proposés par le secrétariat.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageCard() {
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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.softBlue,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'S',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: AppDimensions.sm),

              Expanded(
                child: Text(
                  'Secrétariat',
                  style: AppTextStyles.title.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),

              Text(
                '10h30',
                style: AppTextStyles.caption,
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.md),

          Text(
            'Votre dossier est prêt',
            style: AppTextStyles.title.copyWith(
              fontSize: 15,
            ),
          ),

          const SizedBox(height: AppDimensions.xs),

          Text(
            'Vous pouvez passer au secrétariat pour récupérer votre document.',
            style: AppTextStyles.bodySmall,
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
}

class _ScheduleRow extends StatelessWidget {
  final String day;
  final String hours;

  const _ScheduleRow({
    required this.day,
    required this.hours,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            day,
            style: AppTextStyles.bodySmall,
          ),
        ),

        Text(
          hours,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}