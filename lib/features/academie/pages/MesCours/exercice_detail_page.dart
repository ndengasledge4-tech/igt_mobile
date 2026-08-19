import 'package:flutter/material.dart';

class ExerciceDetailPage extends StatelessWidget {
  final String numero;
  final String titre;
  final String description;
  final String niveau;

  const ExerciceDetailPage({
    super.key,
    required this.numero,
    required this.titre,
    required this.description,
    required this.niveau,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FB),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          'Exercice $numero',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // EN-TÊTE
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFFEAF5FC),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                children: [

                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Text(
                      numero,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1989D5),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          titre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202124),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(6),
                          ),

                          child: Text(
                            niveau,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1989D5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // CONSIGNE
            // ==================================================

            const Text(
              'Consigne',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF666B73),
              ),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // EXERCICE
            // ==================================================

            const Text(
              'Énoncé de l’exercice',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE6EAF0),
                ),
              ),

              child: const Text(
                'Énoncé de l’exercice à compléter.\n\n'
                    'Les questions et les éléments nécessaires '
                    'à la résolution de cet exercice seront '
                    'présentés ici.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.7,
                  color: Color(0xFF555B63),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // BOUTON
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(
                onPressed: () {
                  // Correction / validation à ajouter ensuite.
                },

                icon: const Icon(
                  Icons.check_circle_outline,
                ),

                label: const Text(
                  'Commencer l’exercice',
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF1989D5),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}