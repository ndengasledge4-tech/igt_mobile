import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import 'cours_detail_page.dart';

/// ============================================================
/// PAGE : MES COURS — SEMESTRES
/// ============================================================
///
/// Affiche les semestres disponibles pour une année académique.
///
/// Navigation :
/// Mes cours → Semestre → Cours
/// ============================================================

class SemestrePage extends StatelessWidget {
  final String annee;
  final List<String> semestres;

  const SemestrePage({
    super.key,
    required this.annee,
    required this.semestres,
  });

  @override
  Widget build(BuildContext context) {
    final Color bleu = AppColors.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      // ==========================================================
      // APP BAR
      // ==========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF172033),
            size: 22,
          ),
        ),

        title: Text(
          annee,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),

        centerTitle: false,
      ),

      // ==========================================================
      // CONTENU
      // ==========================================================

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            24,
            22,
            24,
            32,
          ),
          children: [
            // ======================================================
            // DESCRIPTION
            // ======================================================

            const Text(
              'Choisissez un semestre pour accéder aux cours.',
              style: TextStyle(
                color: Color(0xFF667085),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 22),

            // ======================================================
            // SEMESTRES
            // ======================================================

            ...List.generate(
              semestres.length,
                  (index) {
                final String semestre = semestres[index];

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == semestres.length - 1
                        ? 0
                        : 14,
                  ),
                  child: _SemestreCard(
                    semestre: semestre,
                    numero: 'S${index + 1}',
                    nombreCours: _getNombreCours(index),
                    credits: _getCredits(index),
                    couleur: bleu,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CoursDetailPage(
                            semestre: semestre,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // NOMBRE DE COURS
  // =============================================================

  int _getNombreCours(int index) {
    return 5;
  }

  // =============================================================
  // CRÉDITS
  // =============================================================

  int _getCredits(int index) {
    if (index == 0) {
      return 15;
    }

    if (index == 1) {
      return 16;
    }

    return 15;
  }
}

/// ============================================================
/// CARTE SEMESTRE
/// ============================================================

class _SemestreCard extends StatelessWidget {
  final String semestre;
  final String numero;
  final int nombreCours;
  final int credits;
  final Color couleur;
  final VoidCallback onTap;

  const _SemestreCard({
    required this.semestre,
    required this.numero,
    required this.nombreCours,
    required this.credits,
    required this.couleur,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          width: double.infinity,
          height: 142,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE6EAF0),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // ==================================================
              // BLOC S1 / S2
              // ==================================================

              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                ),
                child: Container(
                  width: 76,
                  height: 76,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: couleur.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    numero,
                    style: TextStyle(
                      color: couleur,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 22),

              // ==================================================
              // INFORMATIONS
              // ==================================================

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      semestre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '$nombreCours cours · $credits crédits',
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // FLÈCHE
              // ==================================================

              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: couleur,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}