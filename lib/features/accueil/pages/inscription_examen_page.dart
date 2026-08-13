import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class InscriptionExamenPage extends StatelessWidget {
  const InscriptionExamenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: AppDimensions.appBarHeight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Inscription aux examens',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerCard(),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Informations',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _infoCard(
              Icons.calendar_month_outlined,
              'Période d\'inscription',
              'Du 15 au 30 août 2026',
            ),

            _infoCard(
              Icons.school_outlined,
              'Formation',
              'Informatique de Gestion',
            ),

            _infoCard(
              Icons.class_outlined,
              'Classe',
              'IG2',
            ),

            _infoCard(
              Icons.credit_score_outlined,
              'Frais d\'inscription',
              '15 000 FCFA',
            ),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Pièces à fournir',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _documentItem('Carte d\'étudiant'),
            _documentItem('Reçu de paiement'),
            _documentItem('Quittance académique'),

            const SizedBox(height: AppDimensions.lg),

            // =========================================================
            // BOUTON S'INSCRIRE ACTIF
            // =========================================================

            SizedBox(
              width: double.infinity,
              height: AppDimensions.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  _showInscriptionDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit_calendar_outlined,
                      size: AppDimensions.iconMedium,
                    ),
                    const SizedBox(width: AppDimensions.xs),
                    Text(
                      "S'inscrire aux examens",
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.md),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // BOÎTE DE DIALOGUE DE CONFIRMATION D'INSCRIPTION
  // ===========================================================

  void _showInscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusLarge,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(
              AppDimensions.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // =====================================================
                // ICÔNE DE CONFIRMATION
                // =====================================================

                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.softBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_calendar_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: AppDimensions.md),

                // =====================================================
                // TITRE
                // =====================================================

                Text(
                  'Confirmation d\'inscription',
                  style: AppTextStyles.headline3.copyWith(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.sm),

                // =====================================================
                // MESSAGE
                // =====================================================

                Text(
                  'Souhaitez-vous confirmer votre inscription aux examens de la session 2026 ?',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.xs),

                // =====================================================
                // RÉCAPITULATIF
                // =====================================================

                Container(
                  padding: const EdgeInsets.all(
                    AppDimensions.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softBlue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall,
                    ),
                  ),
                  child: Column(
                    children: [
                      _recapItem('Formation', 'Informatique de Gestion'),
                      const SizedBox(height: 4),
                      _recapItem('Classe', 'IG2'),
                      const SizedBox(height: 4),
                      _recapItem('Frais', '15 000 FCFA'),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.md),

                // =====================================================
                // BOUTONS D'ACTION
                // =====================================================

                Row(
                  children: [

                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.secondaryText,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.sm,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium,
                            ),
                          ),
                        ),
                        child: Text(
                          'Annuler',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: AppDimensions.sm),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showInscriptionSuccess(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.sm,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium,
                            ),
                          ),
                        ),
                        child: Text(
                          'Confirmer',
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================
  // ÉLÉMENT DE RÉCAPITULATIF
  // ===========================================================

  Widget _recapItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // MESSAGE DE SUCCÈS
  // ===========================================================

  void _showInscriptionSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context);
            // Afficher un snackbar de confirmation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Inscription aux examens confirmée avec succès !',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusLarge,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(
              AppDimensions.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // =====================================================
                // ICÔNE DE SUCCÈS
                // =====================================================

                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 40,
                  ),
                ),

                const SizedBox(height: AppDimensions.md),

                // =====================================================
                // MESSAGE DE SUCCÈS
                // =====================================================

                Text(
                  'Inscription confirmée ! ✅',
                  style: AppTextStyles.headline3.copyWith(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.xs),

                Text(
                  'Vous êtes inscrit aux examens de la session 2026.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.sm),

                Container(
                  padding: const EdgeInsets.all(
                    AppDimensions.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softBlue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Un email de confirmation vous sera envoyé',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.md),

                // =====================================================
                // INDICATEUR DE CHARGEMENT
                // =====================================================

                const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
              Icons.assignment_outlined,
              color: Colors.white,
              size: AppDimensions.iconLarge,
            ),
          ),

          const SizedBox(height: AppDimensions.md),

          Text(
            'Inscription aux examens',
            style: AppTextStyles.headline3.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: AppDimensions.sm),

          Text(
            'Consultez les informations et procédez à votre inscription.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: AppDimensions.sm,
      ),
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
                  style: AppTextStyles.caption,
                ),

                const SizedBox(height: AppDimensions.xs),

                Text(
                  value,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentItem(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: AppDimensions.sm,
      ),
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
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.softBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: AppColors.primary,
              size: AppDimensions.iconSmall,
            ),
          ),

          const SizedBox(width: AppDimensions.md),

          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}