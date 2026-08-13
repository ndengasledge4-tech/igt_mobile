import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class MesCoursPage extends StatelessWidget {
  const MesCoursPage({super.key});

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
          'Mes cours',
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
              'Sélectionnez une année pour accéder à vos cours.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.secondaryText,
              ),
            ),

            const SizedBox(height: AppDimensions.lg),

            // =====================================================
            // 1ÈRE ANNÉE
            // =====================================================

            _yearSection(
              context,
              year: '1ère année',
              semesters: 'Semestre 1 — Semestre 2',
              coursesCount: '10 cours disponible(s)',
              isAvailable: true,
              semester1Courses: const [
                'Algorithmique',
                'Programmation',
                'Systèmes d\'exploitation',
                'Réseaux',
                'Mathématiques',
              ],
              semester2Courses: const [
                'Bases de données',
                'Développement Web',
                'Gestion de projet',
                'Anglais technique',
                'Communication',
              ],
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // 2ÈME ANNÉE
            // =====================================================

            _yearSection(
              context,
              year: '2ème année',
              semesters: 'Semestre 3 — Semestre 4',
              coursesCount: '6 cours disponible(s)',
              isAvailable: true,
              semester1Courses: const [
                'Algorithmique avancée',
                'Architecture logicielle',
                'Gestion des données',
              ],
              semester2Courses: const [
                'Intelligence artificielle',
                'Sécurité informatique',
                'Développement mobile',
              ],
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // 3ÈME ANNÉE
            // =====================================================

            _yearSection(
              context,
              year: '3ème année',
              semesters: 'Semestre 5 — Semestre 6',
              coursesCount: 'Pas encore de cours',
              isAvailable: false,
              semester1Courses: const [],
              semester2Courses: const [],
            ),

            const SizedBox(height: AppDimensions.md),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // SECTION ANNÉE
  // ===========================================================

  Widget _yearSection(
      BuildContext context, {
        required String year,
        required String semesters,
        required String coursesCount,
        required bool isAvailable,
        required List<String> semester1Courses,
        required List<String> semester2Courses,
      }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md,
            vertical: 4,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppDimensions.md,
            0,
            AppDimensions.md,
            AppDimensions.md,
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isAvailable
                  ? AppColors.softBlue
                  : AppColors.border,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              isAvailable
                  ? Icons.school_outlined
                  : Icons.lock_outline,
              color: isAvailable
                  ? AppColors.primary
                  : AppColors.secondaryText,
              size: 20,
            ),
          ),
          title: Text(
            year,
            style: AppTextStyles.title.copyWith(
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                semesters,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                coursesCount,
                style: AppTextStyles.caption.copyWith(
                  color: isAvailable
                      ? AppColors.primary
                      : AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          trailing: isAvailable
              ? const Icon(
            Icons.chevron_right,
            color: AppColors.secondaryText,
          )
              : Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.10),
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            child: Text(
              'Indisponible',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
          children: isAvailable
              ? [
            // =====================================================
            // SEMESTRE 1
            // =====================================================

            _semesterSection(
              'Semestre 1',
              semester1Courses,
            ),

            const SizedBox(height: AppDimensions.sm),

            // =====================================================
            // SEMESTRE 2
            // =====================================================

            _semesterSection(
              'Semestre 2',
              semester2Courses,
            ),
          ]
              : [
            // =====================================================
            // MESSAGE INDISPONIBLE
            // =====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                AppDimensions.md,
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
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.secondaryText,
                    size: 32,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  Text(
                    'Les cours de 3ème année ne sont pas encore disponibles.',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.xs),
                  Text(
                    'Revenez plus tard pour découvrir les nouveaux contenus.',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // SECTION SEMESTRE
  // ===========================================================

  Widget _semesterSection(
      String title,
      List<String> courses,
      ) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // =====================================================
          // TITRE DU SEMESTRE
          // =====================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.sm,
              vertical: AppDimensions.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            child: Text(
              title,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: AppDimensions.xs),

          // =====================================================
          // LISTE DES COURS
          // =====================================================

          ...courses.map((course) {
            return _courseItem(course);
          }).toList(),
        ],
      ),
    );
  }

  // ===========================================================
  // ÉLÉMENT COURS
  // ===========================================================

  Widget _courseItem(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: AppDimensions.xs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.sm,
        vertical: AppDimensions.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusSmall,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.menu_book_outlined,
              color: AppColors.primary,
              size: 16,
            ),
          ),
          const SizedBox(width: AppDimensions.sm),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 16,
            color: AppColors.hint,
          ),
        ],
      ),
    );
  }
}