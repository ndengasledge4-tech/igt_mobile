import 'package:flutter/material.dart';

class ChapitrePage extends StatelessWidget {
  final String titre;
  final String numero;
  final String contenu;
  final List<String> objectifs;

  const ChapitrePage({
    super.key,
    required this.titre,
    required this.numero,
    required this.contenu,
    required this.objectifs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      // ==========================================================
      // APP BAR
      // ==========================================================

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
          'Chapitre $numero',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ==========================================================
      // CONTENU
      // ==========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ======================================================
            // NUMÉRO DU CHAPITRE
            // ======================================================

            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: const Color(0xFFEAF5FC),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Text(
                numero,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2789C8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ======================================================
            // TITRE
            // ======================================================

            Text(
              titre,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 28),

            // ======================================================
            // CONTENU DU CHAPITRE
            // ======================================================

            const Text(
              'Contenu du chapitre',
              style: TextStyle(
                fontSize: 18,
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
                  color: const Color(0xFFE9EDF1),
                ),
              ),

              child: Text(
                contenu,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.7,
                  color: Color(0xFF666B73),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ======================================================
            // OBJECTIFS
            // ======================================================

            const Text(
              'Objectifs du chapitre',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 12),

            ...objectifs.map(
                  (objectif) => Padding(
                padding: const EdgeInsets.only(bottom: 12),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Icon(
                      Icons.check_circle_outline,
                      size: 20,
                      color: Color(0xFF2789C8),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        objectif,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Color(0xFF666B73),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}