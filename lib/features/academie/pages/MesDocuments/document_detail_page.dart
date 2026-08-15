import 'package:flutter/material.dart';

/// ============================================================
/// PAGE : DÉTAIL D'UN DOCUMENT
/// ============================================================

class DocumentDetailPage extends StatelessWidget {
  final String titre;
  final String type;
  final String date;
  final String taille;

  const DocumentDetailPage({
    super.key,
    required this.titre,
    required this.type,
    required this.date,
    required this.taille,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Document',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------------------------
            // TYPE
            // --------------------------------------------------
            Container(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: type == 'DOCX'
                    ? const Color(0xFFE8F2FC) // bleu clair
                    : const Color(0xFFFCEBE8), // rouge clair
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: type == 'DOCX'
                      ? const Color(0xFF4D8BC9) // bleu
                      : const Color(0xFFD96B5F), // rouge
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --------------------------------------------------
            // TITRE
            // --------------------------------------------------
            Text(
              titre,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '$date · $taille',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 30),

            // --------------------------------------------------
            // BOUTON TÉLÉCHARGER
            // --------------------------------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Téléchargement à connecter plus tard.
                },
                icon: const Icon(Icons.download_outlined),
                label: const Text('Télécharger'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1989D5),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
