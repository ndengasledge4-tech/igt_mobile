import 'package:flutter/material.dart';

import 'exercice_detail_page.dart';

class ExercicesPage extends StatelessWidget {
  const ExercicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exercices = [
      {
        'numero': '01',
        'titre': 'Exercices d’introduction',
        'description':
        'Exercices permettant de vérifier la compréhension des notions de base.',
        'niveau': 'Facile',
      },
      {
        'numero': '02',
        'titre': 'Notions fondamentales',
        'description':
        'Mettez en pratique les notions fondamentales étudiées dans le cours.',
        'niveau': 'Moyen',
      },
      {
        'numero': '03',
        'titre': 'Concepts avancés',
        'description':
        'Exercices d’application sur les concepts avancés du cours.',
        'niveau': 'Difficile',
      },
      {
        'numero': '04',
        'titre': 'Travaux pratiques',
        'description':
        'Travail pratique permettant d’appliquer les connaissances acquises.',
        'niveau': 'Pratique',
      },
    ];

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

        title: const Text(
          'Exercices',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          24,
        ),
        itemCount: exercices.length,
        itemBuilder: (context, index) {
          final exercice = exercices[index];

          return _ExerciceCard(
            numero: exercice['numero']!,
            titre: exercice['titre']!,
            description: exercice['description']!,
            niveau: exercice['niveau']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciceDetailPage(
                    numero: exercice['numero']!,
                    titre: exercice['titre']!,
                    description: exercice['description']!,
                    niveau: exercice['niveau']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// CARTE EXERCICE
// ============================================================

class _ExerciceCard extends StatelessWidget {
  final String numero;
  final String titre;
  final String description;
  final String niveau;
  final VoidCallback onTap;

  const _ExerciceCard({
    required this.numero,
    required this.titre,
    required this.description,
    required this.niveau,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE6EAF0),
          ),
        ),

        child: Row(
          children: [

            // ==================================================
            // NUMÉRO
            // ==================================================

            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: const Color(0xFFEAF5FC),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Text(
                numero,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1989D5),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // ==================================================
            // INFORMATIONS
            // ==================================================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    titre,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202124),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: Color(0xFF777D85),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF5FC),
                      borderRadius: BorderRadius.circular(6),
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

            const SizedBox(width: 8),

            const Icon(
              Icons.chevron_right,
              color: Color(0xFF8A8F98),
            ),
          ],
        ),
      ),
    );
  }
}