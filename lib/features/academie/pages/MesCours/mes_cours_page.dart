import 'package:flutter/material.dart';

// Importe la carte représentant un semestre.
import '../../../widgets/semestre_card.dart';

// Gestion centralisée des noms de routes.
import '../../../../app/routes/route_names.dart';

/// ============================================================
/// PAGE : MES COURS
/// ============================================================

class MesCoursPage extends StatelessWidget {
  const MesCoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      // --------------------------------------------------------
      // BARRE SUPÉRIEURE
      // --------------------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FB),
        elevation: 0,

        // Bouton retour
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        // Titre
        title: const Text(
          'Mes cours',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // --------------------------------------------------------
      // CONTENU
      // --------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description de la page
            const Text(
              'Sélectionnez une année pour accéder à vos cours.',
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------
            // 1ÈRE ANNÉE
            // --------------------------------------------------
            SemestreCard(
              imagePath: 'assets/images/academie/annee_1.png',
              titre: '1ère année',
              sousTitre: 'Semestre 1 — Semestre 2',
              nombreCours: '10 cours disponible(s)',
              statut: 'En cours',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.semestre,
                  arguments: {
                    'annee': '1ère année',
                    'semestres': ['Semestre 1', 'Semestre 2'],
                  },
                );
              },
            ),
            const SizedBox(height: 14),

            // --------------------------------------------------
            // 2ÈME ANNÉE
            // --------------------------------------------------
            SemestreCard(
              imagePath: 'assets/images/academie/annee_1.png',
              titre: '1ère année',
              sousTitre: 'Semestre 1 — Semestre 2',
              nombreCours: '10 cours disponible(s)',
              statut: 'En cours',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.semestre,
                  arguments: {
                    'annee': '1ère année',
                    'semestres': ['Semestre 1', 'Semestre 2'],
                  },
                );
              },
            ),
            const SizedBox(height: 14),

            // --------------------------------------------------
            // 3ÈME ANNÉE
            // --------------------------------------------------
            SemestreCard(
              imagePath: 'assets/images/academie/annee_3.png',
              titre: '3ème année',
              sousTitre: 'Semestre 5 — Semestre 6',
              nombreCours: 'Pas encore de cours',
              statut: 'À venir',
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}
