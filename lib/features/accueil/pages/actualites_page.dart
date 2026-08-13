import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

import 'inscription_examen_page.dart';
import 'journée_portes_ouvertes.dart';

class ActualitesPage extends StatelessWidget {
  const ActualitesPage({super.key});

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
          'Actualité',
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
              'Actualités',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // ACTUALITÉ 1
            // =====================================================

            _newsItem(
              context,
              date: '17 Nov. 2025',
              title: 'L\'IGT lance son nouveau programme de formation en IA',
              description: 'L\'IGT enrichit son offre pédagogique avec un nouveau module d\'intelligence artificielle.',
              isHighlighted: true,
              onTap: () {
                _showNewsDetail(
                  context,
                  'L\'IGT lance son nouveau programme de formation en IA',
                  'L\'IGT enrichit son offre pédagogique avec un nouveau module d\'intelligence artificielle. Ce programme innovant permettra aux étudiants de se former aux technologies de demain.',
                );
              },
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // ACTUALITÉ 2
            // =====================================================

            _newsItem(
              context,
              date: '15 Nov. 2025',
              title: 'Résultats des examens de rattrapage publiés',
              description: 'Les résultats sont accessibles dans la rubrique Académie > Mes résultats.',
              isHighlighted: false,
              onTap: () {
                _showNewsDetail(
                  context,
                  'Résultats des examens de rattrapage publiés',
                  'Les résultats des examens de rattrapage sont désormais disponibles. Consultez-les dans la rubrique Académie > Mes résultats.',
                );
              },
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // ACTUALITÉ 3
            // =====================================================

            _newsItem(
              context,
              date: '10 Nov. 2025',
              title: 'Bienvenue aux nouveaux étudiants 2025/2026',
              description: 'L\'IGT accueille sa nouvelle promotion avec 300 nouveaux étudiants.',
              isHighlighted: false,
              onTap: () {
                _showNewsDetail(
                  context,
                  'Bienvenue aux nouveaux étudiants 2025/2026',
                  'L\'IGT est ravie d\'accueillir sa nouvelle promotion 2025/2026 avec 300 nouveaux étudiants. Nous leur souhaitons une excellente rentrée académique.',
                );
              },
            ),

            const SizedBox(height: AppDimensions.md),

            // =====================================================
            // ACTUALITÉ 4 (liens vers d'autres pages)
            // =====================================================

            _newsItem(
              context,
              date: '08 Nov. 2025',
              title: 'Inscription aux examens - Session 2026',
              description: 'Les inscriptions pour les examens de fin d\'année sont ouvertes.',
              isHighlighted: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InscriptionExamenPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: AppDimensions.md),

            _newsItem(
              context,
              date: '05 Nov. 2025',
              title: 'Journée portes ouvertes - Édition 2026',
              description: 'Venez découvrir nos formations lors de la journée portes ouvertes.',
              isHighlighted: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const JourneePortesOuvertesPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: AppDimensions.md),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // ÉLÉMENT ACTUALITÉ
  // ===========================================================

  Widget _newsItem(
      BuildContext context, {
        required String date,
        required String title,
        required String description,
        required bool isHighlighted,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          AppDimensions.md,
        ),
        decoration: BoxDecoration(
          color: isHighlighted
              ? AppColors.primary.withOpacity(0.05)
              : AppColors.card,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          border: Border.all(
            color: isHighlighted
                ? AppColors.primary.withOpacity(0.3)
                : AppColors.border,
            width: isHighlighted ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =====================================================
            // DATE
            // =====================================================

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isHighlighted
                        ? AppColors.primary
                        : AppColors.softBlue,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall,
                    ),
                  ),
                  child: Text(
                    date,
                    style: AppTextStyles.caption.copyWith(
                      color: isHighlighted
                          ? Colors.white
                          : AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
                if (isHighlighted) ...[
                  const SizedBox(width: AppDimensions.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusSmall,
                      ),
                    ),
                    child: Text(
                      'À la une',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: AppDimensions.xs),

            // =====================================================
            // TITRE
            // =====================================================

            Text(
              title,
              style: AppTextStyles.title.copyWith(
                fontSize: 15,
                color: isHighlighted
                    ? AppColors.primary
                    : AppColors.text,
              ),
            ),

            const SizedBox(height: AppDimensions.xs),

            // =====================================================
            // DESCRIPTION
            // =====================================================

            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.secondaryText,
              ),
            ),

            const SizedBox(height: AppDimensions.xs),

            // =====================================================
            // LIRE PLUS
            // =====================================================

            Row(
              children: [
                Text(
                  'Lire la suite',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.primary,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // DIALOGUE DÉTAIL ACTUALITÉ
  // ===========================================================

  void _showNewsDetail(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppDimensions.radiusLarge,
          ),
          topRight: Radius.circular(
            AppDimensions.radiusLarge,
          ),
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.70,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.lg,
                AppDimensions.md,
                AppDimensions.lg,
                AppDimensions.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // =====================================================
                  // HEADER
                  // =====================================================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Détail de l\'actualité',
                        style: AppTextStyles.headline3,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.md),

                  // =====================================================
                  // TITRE
                  // =====================================================

                  Container(
                    padding: const EdgeInsets.all(
                      AppDimensions.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBlue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                    ),
                    child: Text(
                      title,
                      style: AppTextStyles.headline3.copyWith(
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.md),

                  // =====================================================
                  // CONTENU
                  // =====================================================

                  Text(
                    content,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.text,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.lg),

                  // =====================================================
                  // BOUTON FERMER
                  // =====================================================

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.md,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium,
                          ),
                        ),
                      ),
                      child: Text(
                        'Fermer',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}