import 'package:flutter/material.dart';

import '../../../widgets/cours_card.dart';

/// ============================================================
/// PAGE : LISTE DES COURS
/// ============================================================

class CoursDetailPage extends StatefulWidget {
  final String semestre;

  const CoursDetailPage({super.key, required this.semestre});

  @override
  State<CoursDetailPage> createState() => _CoursDetailPageState();
}

class _CoursDetailPageState extends State<CoursDetailPage> {
  // ----------------------------------------------------------
  // CONTRÔLEUR DE RECHERCHE
  // ----------------------------------------------------------
  final TextEditingController _searchController = TextEditingController();

  // Liste des cours affichés.
  late List<Map<String, dynamic>> coursFiltres;

  // Liste complète des cours.
  final List<Map<String, dynamic>> tousLesCours = [
    // --------------------------------------------------------
    // SEMESTRE 1
    // --------------------------------------------------------
    {
      'nom': "Introduction à l'informatique",
      'professeur': 'Prof. D. BAMBA',
      'semestre': 'S1',
      'credits': 4,
      'coefficient': 3,
    },

    {
      'nom': 'Algorithmique I',
      'professeur': 'Prof. M. COULIBALY',
      'semestre': 'S1',
      'credits': 4,
      'coefficient': 3,
    },

    {
      'nom': 'Mathématiques I',
      'professeur': 'Prof. A. DIALLO',
      'semestre': 'S1',
      'credits': 3,
      'coefficient': 2,
    },

    {
      'nom': 'Anglais I',
      'professeur': 'Prof. S. MARTIN',
      'semestre': 'S1',
      'credits': 2,
      'coefficient': 1,
    },

    {
      'nom': 'Expression française',
      'professeur': 'Prof. K. TRAORE',
      'semestre': 'S1',
      'credits': 2,
      'coefficient': 1,
    },

    // --------------------------------------------------------
    // SEMESTRE 2
    // --------------------------------------------------------
    {
      'nom': 'Algorithmique II',
      'professeur': 'Prof. M. COULIBALY',
      'semestre': 'S2',
      'credits': 4,
      'coefficient': 3,
    },

    {
      'nom': 'Programmation orientée objet',
      'professeur': 'Prof. F. SANOGO',
      'semestre': 'S2',
      'credits': 4,
      'coefficient': 3,
    },

    {
      'nom': 'Mathématiques II',
      'professeur': 'Prof. A. DIALLO',
      'semestre': 'S2',
      'credits': 3,
      'coefficient': 2,
    },

    {
      'nom': "Systèmes d'information",
      'professeur': 'Prof. I. KONE',
      'semestre': 'S2',
      'credits': 3,
      'coefficient': 2,
    },

    {
      'nom': 'Anglais II',
      'professeur': 'Prof. S. MARTIN',
      'semestre': 'S2',
      'credits': 2,
      'coefficient': 1,
    },

    // --------------------------------------------------------
    // SEMESTRE 3
    // --------------------------------------------------------
    {
      'nom': 'Algorithmique avancée',
      'professeur': 'Prof. M. COULIBALY',
      'semestre': 'S3',
      'credits': 4,
      'coefficient': 3,
    },

    {
      'nom': 'Bases de données',
      'professeur': 'Prof. A. DIALLO',
      'semestre': 'S3',
      'credits': 3,
      'coefficient': 2,
    },

    {
      'nom': 'Réseaux informatiques',
      'professeur': 'Prof. K. TRAORE',
      'semestre': 'S3',
      'credits': 4,
      'coefficient': 3,
    },

    {
      'nom': 'Génie logiciel',
      'professeur': 'Prof. F. SANOGO',
      'semestre': 'S3',
      'credits': 3,
      'coefficient': 2,
    },

    {
      'nom': "Systèmes d'exploitation",
      'professeur': 'Prof. I. KONE',
      'semestre': 'S3',
      'credits': 4,
      'coefficient': 3,
    },

    {
      'nom': "Mathématiques pour l'info",
      'professeur': 'Prof. D. BAMBA',
      'semestre': 'S3',
      'credits': 3,
      'coefficient': 2,
    },
  ];

  @override
  void initState() {
    super.initState();

    // On affiche uniquement les cours correspondant
    // au semestre sélectionné.
    coursFiltres = tousLesCours
        .where(
          (cours) => cours['semestre'] == _getNumeroSemestre(widget.semestre),
        )
        .toList();
  }

  // ----------------------------------------------------------
  // TRANSFORMATION
  // ----------------------------------------------------------
  // "Semestre 1" → "S1"
  // "Semestre 2" → "S2"
  // etc.
  String _getNumeroSemestre(String semestre) {
    return semestre.replaceAll('Semestre ', 'S');
  }

  // ----------------------------------------------------------
  // RECHERCHE
  // ----------------------------------------------------------
  void _rechercherCours(String recherche) {
    final rechercheMinuscule = recherche.toLowerCase();

    setState(() {
      coursFiltres = tousLesCours.where((cours) {
        final bonSemestre =
            cours['semestre'] == _getNumeroSemestre(widget.semestre);

        final nomCours = cours['nom'].toString().toLowerCase();

        return bonSemestre && nomCours.contains(rechercheMinuscule);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final semestreNumero = _getNumeroSemestre(widget.semestre);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      // --------------------------------------------------------
      // APP BAR
      // --------------------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FB),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          widget.semestre,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // --------------------------------------------------------
      // CONTENU
      // --------------------------------------------------------
      body: Column(
        children: [
          // ----------------------------------------------------
          // BARRE DE RECHERCHE
          // ----------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),

            child: TextField(
              controller: _searchController,

              onChanged: _rechercherCours,

              decoration: InputDecoration(
                hintText: 'Rechercher un cours...',

                prefixIcon: const Icon(Icons.search, color: Colors.black45),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE6E8EC)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE6E8EC)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFF1976D2)),
                ),
              ),
            ),
          ),

          // ----------------------------------------------------
          // LISTE DES COURS
          // ----------------------------------------------------
          Expanded(
            child: coursFiltres.isEmpty
                // ----------------------------------------------
                // AUCUN COURS
                // ----------------------------------------------
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 55,
                          color: Color(0xFF8BC34A),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Aucun cours',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Aucun cours disponible pour $semestreNumero.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                // ----------------------------------------------
                // COURS DISPONIBLES
                // ----------------------------------------------
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    itemCount: coursFiltres.length,

                    itemBuilder: (context, index) {
                      final cours = coursFiltres[index];

                      return CoursCard(
                        nom: cours['nom'],
                        professeur: cours['professeur'],
                        semestre: cours['semestre'],
                        credits: cours['credits'],
                        coefficient: cours['coefficient'],

                        onTap: () {
                          // Pour l'instant, on pourra brancher
                          // ici la vraie page de détail du cours.
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
