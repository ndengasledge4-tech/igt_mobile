import 'package:flutter/material.dart';
import '../../../../app/theme/colors.dart';

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
      backgroundColor: const Color(0xFFF8F9FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================================================
              // RETOUR + TITRE
              // ========================================================

              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: bleu,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Text(
                      'Détail du cours',
                      style: TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

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
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ========================================================
              // INFORMATIONS
              // ========================================================

              _info(
                Icons.access_time,
                'Horaire',
                horaire,
                bleu,
              ),

              _info(
                Icons.room_outlined,
                'Salle',
                salle,
                bleu,
              ),

              _info(
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: bleu.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: bleu,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titre,
                style: const TextStyle(
                  color: Color(0xFF8A9099),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                valeur,
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}