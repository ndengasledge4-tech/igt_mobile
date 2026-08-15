import 'package:flutter/material.dart';

import '../../../widgets/resultat_card.dart';

import '../../../../app/theme/colors.dart';

/// Page permettant à l'étudiant de consulter ses résultats académiques.
class MesResultatsPage extends StatelessWidget {
  const MesResultatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FC),
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1769AA)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Mes résultats',
          style: TextStyle(
            color: Color(0xFF172033),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================================
            // RÉSULTAT ANNUEL
            // ============================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RÉSULTAT ANNUEL — 2025/2026',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '15.20',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 6),

                      const Text(
                        '/ 20',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mention : Bien',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Admis',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '48 / 60 crédits',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================================
            // SEMESTRE 3
            // ============================================================
            const ResultatCard(
              semestre: 'Semestre 3',
              moyenne: '15.20',
              credits: '28/30',
              mention: 'Bien',
              statut: 'Validé',
            ),

            // ============================================================
            // SEMESTRE 1
            // ============================================================
            const ResultatCard(
              semestre: 'Semestre 1',
              moyenne: '14.80',
              credits: '28/30',
              mention: 'Assez\nBien',
              statut: 'Validé',
            ),

            // ============================================================
            // SEMESTRE 2
            // ============================================================
            const ResultatCard(
              semestre: 'Semestre 2',
              moyenne: '13.50',
              credits: '28/30',
              mention: 'Assez\nBien',
              statut: 'Validé',
            ),
          ],
        ),
      ),
    );
  }
}
