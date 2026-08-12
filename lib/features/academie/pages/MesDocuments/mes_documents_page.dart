import 'package:flutter/material.dart';

import '../../../widgets/document_card.dart';
import 'document_detail_page.dart';

/// ============================================================
/// PAGE : MES DOCUMENTS
/// ============================================================

class MesDocumentsPage extends StatefulWidget {
  const MesDocumentsPage({super.key});

  @override
  State<MesDocumentsPage> createState() => _MesDocumentsPageState();
}

class _MesDocumentsPageState extends State<MesDocumentsPage> {
  int selectedCategory = 0;

  final List<String> categories = [
    'Tous',
    'Admin',
    'Académique',
    'Cours',
    'Formulaires',
  ];

  /// ==========================================================
  /// DOCUMENTS
  /// ==========================================================

  final List<Map<String, String>> documents = [
    {
      'type': 'PDF',
      'titre': 'Règlement intérieur 2025',
      'date': '01/09/2025',
      'taille': '1.2 MB',
      'categorie': 'Admin',
    },
    {
      'type': 'PDF',
      'titre': 'Programme S3 – IG2',
      'date': '05/09/2025',
      'taille': '890 KB',
      'categorie': 'Académique',
    },
    {
      'type': 'PDF',
      'titre': 'Cours Algo – Chap. 1',
      'date': '15/09/2025',
      'taille': '4.1 MB',
      'categorie': 'Cours',
    },
    {
      'type': 'DOCX',
      'titre': 'Formulaire de demande',
      'date': '20/09/2025',
      'taille': '240 KB',
      'categorie': 'Formulaires',
    },
    {
      'type': 'PDF',
      'titre': 'Calendrier des examens',
      'date': '22/09/2025',
      'taille': '350 KB',
      'categorie': 'Admin',
    },
    {
      'type': 'PDF',
      'titre': 'TP BDD – Exercices',
      'date': '28/09/2025',
      'taille': '1.8 MB',
      'categorie': 'Cours',
    },
  ];

  /// ==========================================================
  /// FILTRAGE
  /// ==========================================================

  List<Map<String, String>> get filteredDocuments {
    if (selectedCategory == 0) {
      return documents;
    }

    final categorie = categories[selectedCategory];

    return documents
        .where(
          (document) => document['categorie'] == categorie,
    )
        .toList();
  }

  /// ==========================================================
  /// OUVRIR LE DOCUMENT
  /// ==========================================================

  void openDocument(Map<String, String> document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentDetailPage(
          titre: document['titre']!,
          type: document['type']!,
          date: document['date']!,
          taille: document['taille']!,
        ),
      ),
    );
  }

  /// ==========================================================
  /// CONSTRUCTION
  /// ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      body: SafeArea(
        child: Column(
          children: [
            // ==================================================
            // EN-TÊTE
            // ==================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                4,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                    ),
                  ),

                  const SizedBox(width: 4),

                  const Text(
                    'Mes documents',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // CATÉGORIES
            // ==================================================

            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final bool selected =
                      selectedCategory == index;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 180,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF1989D5)
                              : Colors.transparent,
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: selected
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // LISTE DES DOCUMENTS
            // ==================================================

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  20,
                ),
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  final document =
                  filteredDocuments[index];

                  return DocumentCard(
                    type: document['type']!,
                    titre: document['titre']!,
                    date: document['date']!,
                    taille: document['taille']!,
                    onView: () {
                      openDocument(document);
                    },
                    onDownload: () {
                      // Téléchargement à connecter plus tard.
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}