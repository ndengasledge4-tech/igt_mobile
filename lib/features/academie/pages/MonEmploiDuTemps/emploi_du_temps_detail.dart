import 'package:flutter/material.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/premium_ui.dart';

class EmploiDuTempsDetail extends StatelessWidget {
  final String matiere;
  final String horaire;
  final String salle;
  final String professeur;

  const EmploiDuTempsDetail({
    super.key,
    required this.matiere,
    required this.horaire,
    required this.salle,
    required this.professeur,
  });

  @override
  Widget build(BuildContext context) {
    final Color bleu = AppColors.primary;

    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Détail du cours',
        subtitle: 'Horaire, salle et enseignant',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          maxWidth: 720,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================================================
              // CARTE PRINCIPALE
              // ========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: bleu,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.school_outlined,
                      color: Colors.white,
                      size: 34,
                    ),

                    const SizedBox(height: 18),

                    Text(
                      matiere,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Lundi 17 novembre 2025',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ========================================================
              // INFORMATIONS
              // ========================================================
              _info(context, Icons.access_time, 'Horaire', horaire, bleu),

              _info(context, Icons.room_outlined, 'Salle', salle, bleu),

              _info(
                context,
                Icons.person_outline,
                'Professeur',
                professeur,
                bleu,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(
    BuildContext context,
    IconData icon,
    String titre,
    String valeur,
    Color bleu,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: bleu.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: bleu, size: 22),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: TextStyle(
                    color: context.semanticColors.textSecondary,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  valeur,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15,
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
}
