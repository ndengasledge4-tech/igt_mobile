import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class MesNotesPage extends StatelessWidget {
  const MesNotesPage({super.key});

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
          'Mes notes',
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
              'Sélectionnez une année académique pour consulter vos notes.',
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
              notesCount: '10 note(s) disponible(s)',
              isAvailable: true,
              semester1Notes: const [
                {'subject': 'Algorithmique', 'note': '16.5 / 20', 'good': true},
                {'subject': 'Programmation', 'note': '14.0 / 20', 'good': true},
                {'subject': 'Systèmes d\'exploitation', 'note': '12.5 / 20', 'good': false},
                {'subject': 'Réseaux', 'note': '15.0 / 20', 'good': true},
                {'subject': 'Mathématiques', 'note': '11.0 / 20', 'good': false},
              ],
              semester2Notes: const [
                {'subject': 'Bases de données', 'note': '13.5 / 20', 'good': false},
                {'subject': 'Développement Web', 'note': '17.0 / 20', 'good': true},
                {'subject': 'Gestion de projet', 'note': '14.5 / 20', 'good': true},
                {'subject': 'Anglais technique', 'note': '12.0 / 20', 'good': false},
                {'subject': 'Communication', 'note': '15.5 / 20', 'good': true},
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
              notesCount: '6 note(s) disponible(s)',
              isAvailable: true,
              semester1Notes: const [
                {'subject': 'Algorithmique avancée', 'note': '16.0 / 20', 'good': true},
                {'subject': 'Architecture logicielle', 'note': '13.5 / 20', 'good': false},
                {'subject': 'Gestion des données', 'note': '15.0 / 20', 'good': true},
              ],
              semester2Notes: const [
                {'subject': 'Intelligence artificielle', 'note': '18.0 / 20', 'good': true},
                {'subject': 'Sécurité informatique', 'note': '14.0 / 20', 'good': true},
                {'subject': 'Développement mobile', 'note': '12.5 / 20', 'good': false},
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
              notesCount: 'Pas encore de notes',
              isAvailable: false,
              semester1Notes: const [],
              semester2Notes: const [],
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
        required String notesCount,
        required bool isAvailable,
        required List<Map<String, dynamic>> semester1Notes,
        required List<Map<String, dynamic>> semester2Notes,
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
                  ? Icons.grade_outlined
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
                notesCount,
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
              semester1Notes,
            ),

            const SizedBox(height: AppDimensions.sm),

            // =====================================================
            // SEMESTRE 2
            // =====================================================

            _semesterSection(
              'Semestre 2',
              semester2Notes,
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
                    'Les notes de 3ème année ne sont pas encore disponibles.',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.xs),
                  Text(
                    'Revenez plus tard pour consulter vos notes.',
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
      List<Map<String, dynamic>> notes,
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
          // LISTE DES NOTES
          // =====================================================

          ...notes.map((noteData) {
            return _noteItem(
              noteData['subject'],
              noteData['note'],
              noteData['good'],
            );
          }).toList(),
        ],
      ),
    );
  }

  // ===========================================================
  // ÉLÉMENT NOTE
  // ===========================================================

  Widget _noteItem(
      String subject,
      String note,
      bool good,
      ) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: good
                      ? AppColors.success.withOpacity(0.10)
                      : AppColors.warning.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  good
                      ? Icons.check_circle_outline
                      : Icons.warning_amber_outlined,
                  color: good
                      ? AppColors.success
                      : AppColors.warning,
                  size: 16,
                ),
              ),
              const SizedBox(width: AppDimensions.sm),
              Text(
                subject,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            note,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: good
                  ? AppColors.success
                  : AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}