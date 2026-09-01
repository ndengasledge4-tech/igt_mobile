import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/premium_ui.dart';
import '../../../widgets/parcours_academique_card.dart';
import '../../../widgets/semestre_card.dart';

import '../../../../app/routes/route_names.dart';

/// Page permettant à l'étudiant de consulter son parcours académique.
class MonParcoursPage extends StatelessWidget {
  const MonParcoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Mon parcours',
        subtitle: 'Formation, niveau et semestres',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bloc contenant les informations académiques.
              ParcoursAcademiqueCard(
                title: 'Informations académiques',
                items: const [
                  {'label': 'Formation', 'value': 'Informatique de Gestion'},
                  {'label': 'Niveau', 'value': 'Deuxième année'},
                  {'label': 'Classe', 'value': 'IG2'},
                  {'label': 'Campus', 'value': 'Campus principal'},
                  {'label': 'Année académique', 'value': '2025–2026'},
                  {'label': 'Parcours', 'value': 'Génie logiciel'},
                ],
              ),

              const SizedBox(height: 24),

              // Titre de la section des semestres.
              Text(
                'Semestres de la 2ème année',
                style: AppTextStyles.title.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              // Semestre 3.
              SemestreCard(
                imagePath: 'assets/images/academie/annee_2.png',
                titre: 'Semestre 3',
                sousTitre: '6 matières · 30 crédits',
                nombreCours: '6 matières disponibles',
                statut: 'En cours',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.semestre,
                    arguments: {
                      'annee': '2ème année',
                      'semestres': ['Semestre 3'],
                    },
                  );
                },
              ),
              const SizedBox(height: 12),

              // Semestre 4.
              SemestreCard(
                imagePath: 'assets/images/academie/annee_2.png',
                titre: 'Semestre 4',
                sousTitre: '6 matières · 30 crédits',
                nombreCours: '6 matières disponibles',
                statut: 'À venir',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.semestre,
                    arguments: {
                      'annee': '2ème année',
                      'semestres': ['Semestre 4'],
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
