import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ResultatsPage extends StatelessWidget {
  const ResultatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mes résultats',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =====================================================
            // TITRE DE SECTION
            // =====================================================

            Text(
              'RÉSULTAT ANNUEL — 2025/2026',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.secondaryText,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: AppDimensions.sm),

            // =====================================================
            // CARTE RÉSULTAT GLOBAL
            // =====================================================

            _resultGlobalCard(),

            const SizedBox(height: AppDimensions.lg),

            // =====================================================
            // SEMESTRE 3
            // =====================================================

            _semesterResult(
              semester: 'Semestre 3',
              status: 'Validé',
              statusColor: AppColors.success,
              average: '15.20',
              credits: '28/30',
              mention: 'Bien',
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // SEMESTRE 1
            // =====================================================

            _semesterResult(
              semester: 'Semestre 1',
              status: 'Validé',
              statusColor: AppColors.success,
              average: '14.80',
              credits: '28/30',
              mention: 'Assez Bien',
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // SEMESTRE 2
            // =====================================================

            _semesterResult(
              semester: 'Semestre 2',
              status: 'Validé',
              statusColor: AppColors.success,
              average: '13.50',
              credits: '28/30',
              mention: 'Assez Bien',
            ),

            const SizedBox(height: AppDimensions.md),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // CARTE RÉSULTAT GLOBAL
  // ===========================================================

  Widget _resultGlobalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppDimensions.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [

          // =====================================================
          // MOYENNE GÉNÉRALE
          // =====================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '15.20',
                      style: AppTextStyles.headline2.copyWith(
                        color: AppColors.primary,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '/ 20',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.sm),

          // =====================================================
          // MENTION
          // =====================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.md,
              vertical: AppDimensions.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.10),
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            child: Text(
              'Mention : Bien',
              style: AppTextStyles.title.copyWith(
                color: AppColors.success,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: AppDimensions.xs),

          // =====================================================
          // STATUT
          // =====================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.md,
              vertical: AppDimensions.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.10),
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Admis',
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.success,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.md),

          // =====================================================
          // CRÉDITS
          // =====================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              AppDimensions.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusMedium,
              ),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.credit_score_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: AppDimensions.sm),
                Text(
                  '48 / 60 crédits',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // RÉSULTAT PAR SEMESTRE
  // ===========================================================

  Widget _semesterResult({
    required String semester,
    required String status,
    required Color statusColor,
    required String average,
    required String credits,
    required String mention,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // =====================================================
          // EN-TÊTE SEMESTRE
          // =====================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                semester,
                style: AppTextStyles.headline3.copyWith(
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: statusColor,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: AppTextStyles.caption.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.sm),

          // =====================================================
          // DÉTAILS
          // =====================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              AppDimensions.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: Column(
              children: [

                // Moyenne
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Moyenne',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Text(
                      average,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Crédits
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Crédits',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Text(
                      credits,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Mention
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mention',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Text(
                      mention,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}