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
              // APPBAR
              // ========================================================

              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF172033),
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(width: 8),

                  const Expanded(
                    child: Text(
                      'Détail du cours',
                      style: TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ========================================================
              // GRANDE CARTE EN IMAGE
              // ========================================================

              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: bleu.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // IMAGE PNG DE LA CARTE
                    Image.asset(
                      'assets/images/academie/course_detail_card.png',
                      fit: BoxFit.cover,
                    ),

                    // CONTENU PAR-DESSUS L'IMAGE
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        22,
                        20,
                        22,
                        22,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          // Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'COURS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),

                          const Spacer(),

                          Text(
                            matiere,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              height: 1.15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 9),

                          Row(
                            children: [
                              Image.asset(
                                'assets/images/academie/calendar.png',
                                width: 18,
                                height: 18,
                              ),

                              const SizedBox(width: 8),

                              const Text(
                                'Lundi 17 novembre 2025',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ========================================================
              // TITRE
              // ========================================================

              const Text(
                'Informations du cours',
                style: TextStyle(
                  color: Color(0xFF172033),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              // ========================================================
              // HORAIRE
              // ========================================================

              _infoCard(
                image: 'assets/images/academie/time.png',
                titre: 'Horaire',
                valeur: horaire,
              ),

              // ========================================================
              // SALLE
              // ========================================================

              _infoCard(
                image: 'assets/images/academie/location.png',
                titre: 'Salle',
                valeur: salle,
              ),

              // ========================================================
              // PROFESSEUR
              // ========================================================

              _infoCard(
                image: 'assets/images/academie/professor.png',
                titre: 'Professeur',
                valeur: professeur,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // CARTE INFORMATION
  // ==============================================================

  Widget _infoCard({
    required String image,
    required String titre,
    required String valeur,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE6E9EF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // ==========================================================
          // IMAGE PNG
          // ==========================================================

          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F6FB),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(11),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 14),

          // ==========================================================
          // INFORMATIONS
          // ==========================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: const TextStyle(
                    color: Color(0xFF8A9099),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),

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
          ),
        ],
      ),
    );
  }
}