import 'package:flutter/material.dart';

// Importation des couleurs personnalisées de l'application.
import '../../../app/theme/colors.dart';

// Importation des styles de texte personnalisés de l'application.
import '../../../app/theme/text_styles.dart';

// Importation de la carte représentant chaque rubrique académique.
import '../../widgets/rubrique_academique_card.dart';

/// Page principale du module Académie.
///
/// Cette page présente les différentes rubriques académiques
/// accessibles à l'étudiant.
class AcademiePage extends StatelessWidget {
  const AcademiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Couleur de fond générale de la page.
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // ============================================================
            // EN-TÊTE DE LA PAGE ACADÉMIE
            // ============================================================
            Container(
              width: double.infinity,

              // Espacement interne de l'en-tête.
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),

              // Style visuel de l'en-tête.
              decoration: BoxDecoration(
                color: AppColors.primary,

                // Arrondissement uniquement des deux coins inférieurs.
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre principal de la page.
                  Text(
                    'Académie',
                    style: AppTextStyles.title.copyWith(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  // Espace entre le titre et les informations
                  // concernant le parcours de l'étudiant.
                  const SizedBox(height: 6),

                  // Informations sur la formation, le niveau
                  // et la classe de l'étudiant.
                  const Text(
                    'Informatique de Gestion · 2ème année · IG2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // ============================================================
            // RUBRIQUES ACADÉMIQUES
            // ============================================================
            Expanded(
              child: GridView.count(
                // Espacement autour de la grille.
                padding: const EdgeInsets.all(16),

                // Deux cartes par ligne.
                crossAxisCount: 2,

                // Espacement horizontal entre les cartes.
                crossAxisSpacing: 12,

                // Espacement vertical entre les cartes.
                mainAxisSpacing: 12,

                // Proportion largeur/hauteur des cartes.
                childAspectRatio: 0.88,

                children: [
                  // ------------------------------------------------------
                  // MON PARCOURS
                  // ------------------------------------------------------
                  RubriqueAcademiqueCard(
                    title: 'Mon parcours',
                    description:
                    'Formation, niveau, classe et semestres',
                    iconPath: 'assets/images/academie/mon_parcours.png',

                    // Navigation vers la page Mon parcours.
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/mon-parcours',
                      );
                    },
                  ),

                  // ------------------------------------------------------
                  // MES COURS
                  // ------------------------------------------------------
                  RubriqueAcademiqueCard(
                    title: 'Mes cours',
                    description: 'Tous vos cours par semestre',
                    iconPath: 'assets/images/academie/mes_cours.png',

                    // Navigation vers la page Mes cours.
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/mes-cours',
                      );
                    },
                  ),

                  // ------------------------------------------------------
                  // MES NOTES
                  // ------------------------------------------------------
                  RubriqueAcademiqueCard(
                    title: 'Mes notes',
                    description:
                    'Consulter vos notes et coefficients',
                    iconPath: 'assets/images/academie/mes_notes.png',

                    // Navigation vers la page Mes notes.
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/mes-notes',
                      );
                    },
                  ),

                  // ------------------------------------------------------
                  // MES RÉSULTATS
                  // ------------------------------------------------------
                  RubriqueAcademiqueCard(
                    title: 'Mes résultats',
                    description:
                    'Moyennes, crédits et mentions',
                    iconPath: 'assets/images/academie/mes_resultats.png',

                    // Navigation vers la page Mes résultats.
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/mes-resultats',
                      );
                    },
                  ),

                  // ------------------------------------------------------
                  // MON EMPLOI DU TEMPS
                  // ------------------------------------------------------
                  RubriqueAcademiqueCard(
                    title: 'Mon emploi du temps',
                    description:
                    'Vues jour, semaine et mois',
                    iconPath: 'assets/images/academie/emploi_du_temps.png',

                    // Navigation vers la page Emploi du temps.
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/emploi-du-temps',
                      );
                    },
                  ),

                  // ------------------------------------------------------
                  // MES DOCUMENTS
                  // ------------------------------------------------------
                  RubriqueAcademiqueCard(
                    title: 'Mes documents',
                    description:
                    'Cours, formulaires et docs admin',
                    iconPath: 'assets/images/academie/mes_documents.png',

                    // Navigation vers la page Mes documents.
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/mes-documents',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}