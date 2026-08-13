import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class JourneePortesOuvertesPage extends StatelessWidget {
  const JourneePortesOuvertesPage({super.key});

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
          'Journée portes ouvertes',
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
              'Événement',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _eventItem(
              Icons.calendar_today_outlined,
              'Date',
              'Samedi 29 août 2026',
            ),

            _eventItem(
              Icons.access_time_outlined,
              'Heure',
              '09h00 – 16h00',
            ),

            _eventItem(
              Icons.location_on_outlined,
              'Lieu',
              'Campus principal',
            ),

            _eventItem(
              Icons.people_outline,
              'Public concerné',
              'Étudiants, parents et nouveaux candidats',
            ),

            const SizedBox(height: AppDimensions.lg),

            Text(
              'Au programme',
              style: AppTextStyles.headline3,
            ),

            const SizedBox(height: AppDimensions.sm),

            _programItem(
              'Présentation des formations',
            ),

            _programItem(
              'Visite des locaux',
            ),

            _programItem(
              'Rencontre avec les enseignants',
            ),

            _programItem(
              'Présentation des services étudiants',
            ),

            _programItem(
              'Séance de questions / réponses',
            ),

            const SizedBox(height: AppDimensions.lg),

            // =========================================================
            // BOUTON PARTICIPER ACTIF
            // =========================================================

            SizedBox(
              width: double.infinity,
              height: AppDimensions.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  _showParticipationDialog(context);
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
                      Icons.event_outlined,
                      size: AppDimensions.iconMedium,
                    ),
                    const SizedBox(width: AppDimensions.xs),
                    Text(
                      "Participer à l'événement",
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
  // BOÎTE DE DIALOGUE DE CONFIRMATION
  // ===========================================================

  void _showParticipationDialog(BuildContext context) {
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
                    Icons.event_available_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: AppDimensions.md),

                // =====================================================
                // TITRE
                // =====================================================

                Text(
                  'Confirmation de participation',
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
                  'Souhaitez-vous confirmer votre participation à la Journée portes ouvertes du 29 août 2026 ?',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  textAlign: TextAlign.center,
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
                          _showParticipationSuccess(context);
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
  // MESSAGE DE SUCCÈS
  // ===========================================================

  void _showParticipationSuccess(BuildContext context) {
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
                    Text(
                      'Votre participation a été enregistrée avec succès !',
                      style: TextStyle(
                        color: Colors.white,
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
                  'Participation confirmée ! 🎉',
                  style: AppTextStyles.headline3.copyWith(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.xs),

                Text(
                  'Vous êtes inscrit pour la Journée portes ouvertes.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  textAlign: TextAlign.center,
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
              Icons.event_available_outlined,
              color: Colors.white,
              size: AppDimensions.iconLarge,
            ),
          ),

          const SizedBox(height: AppDimensions.md),

          Text(
            'Journée portes ouvertes',
            style: AppTextStyles.headline3.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: AppDimensions.sm),

          Text(
            'Découvrez nos formations, nos services et notre environnement académique.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventItem(
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

  Widget _programItem(String text) {
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