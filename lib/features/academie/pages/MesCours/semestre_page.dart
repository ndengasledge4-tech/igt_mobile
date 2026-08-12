import 'package:flutter/material.dart';

// Importe la carte représentant un cours.
import '../../../widgets/semestre_card.dart';

// Importe la page de détail d'un cours.
import 'cours_detail_page.dart';

/// ============================================================
/// PAGE : SEMESTRE
/// ============================================================

class SemestrePage extends StatelessWidget {
  final String annee;
  final List<String> semestres;

  const SemestrePage({
    super.key,
    required this.annee,
    required this.semestres,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      // --------------------------------------------------------
      // APP BAR
      // --------------------------------------------------------
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
          annee,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Choisissez un semestre pour accéder aux cours.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 20),

            // Génération des cartes de semestre
            ...List.generate(
              semestres.length,
                  (index) {

                final semestre = semestres[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 14,
                  ),

                  child: _SemestreItem(
                    semestre: semestre,
                    onTap: () {

                      // ------------------------------------------------
                      // NAVIGATION VERS LA LISTE DES COURS
                      // ------------------------------------------------
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CoursDetailPage(
                            semestre: semestre,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// WIDGET INTERNE : SEMESTRE ITEM
/// ============================================================
///
/// Ce widget reste dans la page car il est spécifique à cette
/// page. On ne crée donc pas inutilement un nouveau fichier.
/// ============================================================

class _SemestreItem extends StatelessWidget {
  final String semestre;
  final VoidCallback onTap;

  const _SemestreItem({
    required this.semestre,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    // Extraction de S1, S2, S3...
    final numero = semestre
        .replaceAll('Semestre ', 'S');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 22,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: const Color(0xFFE6E8EC),
          ),
        ),

        child: Row(
          children: [

            // --------------------------------------------------
            // NUMÉRO DU SEMESTRE
            // --------------------------------------------------
            SizedBox(
              width: 55,

              child: Text(
                numero,
                style: const TextStyle(
                  color: Color(0xFF1976D2),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            // --------------------------------------------------
            // NOM DU SEMESTRE
            // --------------------------------------------------
            Expanded(
              child: Text(
                semestre,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}