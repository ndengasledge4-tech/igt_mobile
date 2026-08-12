import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

/// Page de détail d'un résultat académique.
class ResultatDetailPage extends StatelessWidget {
  final String semestre;
  final String moyenne;
  final String credits;
  final String mention;

  const ResultatDetailPage({
    super.key,
    this.semestre = 'Semestre 3',
    this.moyenne = '15.20',
    this.credits = '28/30',
    this.mention = 'Bien',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      // ============================================================
      // BARRE SUPÉRIEURE
      // ============================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FC),
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1769AA),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Détail du résultat',
          style: TextStyle(
            color: Color(0xFF172033),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ============================================================
      // CONTENU
      // ============================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ========================================================
            // EN-TÊTE DU SEMESTRE
            // ========================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    semestre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Année académique 2025/2026',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [

                      Expanded(
                        child: _InfoBloc(
                          valeur: moyenne,
                          label: 'Moyenne',
                        ),
                      ),

                      Expanded(
                        child: _InfoBloc(
                          valeur: credits,
                          label: 'Crédits',
                        ),
                      ),

                      Expanded(
                        child: _InfoBloc(
                          valeur: mention,
                          label: 'Mention',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ========================================================
            // INFORMATIONS DU RÉSULTAT
            // ========================================================

            const Text(
              'Informations',
              style: TextStyle(
                color: Color(0xFF172033),
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                children: [

                  _InformationRow(
                    label: 'Semestre',
                    valeur: semestre,
                  ),

                  const Divider(height: 24),

                  _InformationRow(
                    label: 'Moyenne générale',
                    valeur: '$moyenne / 20',
                  ),

                  const Divider(height: 24),

                  _InformationRow(
                    label: 'Crédits obtenus',
                    valeur: credits,
                  ),

                  const Divider(height: 24),

                  _InformationRow(
                    label: 'Mention',
                    valeur: mention,
                  ),

                  const Divider(height: 24),

                  const _InformationRow(
                    label: 'Statut',
                    valeur: 'Validé',
                    valeurColor: Color(0xFF4CAF50),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ========================================================
            // MATIÈRES
            // ========================================================

            const Text(
              'Matières',
              style: TextStyle(
                color: Color(0xFF172033),
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            _MatiereCard(
              nom: 'Développement mobile',
              note: '16.50',
              credits: '5 crédits',
            ),

            _MatiereCard(
              nom: 'Base de données',
              note: '15.00',
              credits: '5 crédits',
            ),

            _MatiereCard(
              nom: 'Génie logiciel',
              note: '14.50',
              credits: '5 crédits',
            ),

            _MatiereCard(
              nom: 'Réseaux informatiques',
              note: '15.50',
              credits: '5 crédits',
            ),

            _MatiereCard(
              nom: 'Gestion de projet',
              note: '14.00',
              credits: '5 crédits',
            ),

            _MatiereCard(
              nom: 'Anglais',
              note: '16.00',
              credits: '5 crédits',
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// BLOC INFORMATIONS DU HAUT
// ================================================================

class _InfoBloc extends StatelessWidget {
  final String valeur;
  final String label;

  const _InfoBloc({
    required this.valeur,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          valeur,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// LIGNE D'INFORMATION
// ================================================================

class _InformationRow extends StatelessWidget {
  final String label;
  final String valeur;
  final Color valeurColor;

  const _InformationRow({
    required this.label,
    required this.valeur,
    this.valeurColor = const Color(0xFF172033),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),

        Flexible(
          child: Text(
            valeur,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valeurColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ================================================================
// CARTE MATIÈRE
// ================================================================

class _MatiereCard extends StatelessWidget {
  final String nom;
  final String note;
  final String credits;

  const _MatiereCard({
    required this.nom,
    required this.note,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [

          // Icône
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.menu_book_outlined,
              color: Color(0xFF1769AA),
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          // Nom de la matière
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  nom,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  credits,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Note
          Text(
            note,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}