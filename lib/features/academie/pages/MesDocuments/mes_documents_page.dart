import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/document_card.dart';
import 'document_detail_page.dart';

class MesDocumentsPage extends StatefulWidget {
  final int initialCategory;

  const MesDocumentsPage({
    super.key,
    this.initialCategory = 0,
  });

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

  final List<Map<String, String>> documents = [
    {
      'type': 'PDF',
      'titre': 'Règlement intérieur 2025',
      'date': '01/09/2025',
      'taille': '1.2 MB',
      'categorie': 'Admin',
      'url': 'https://exemple.com/reglement-interieur-2025.pdf',
    },
    {
      'type': 'PDF',
      'titre': 'Programme S3 – IG2',
      'date': '05/09/2025',
      'taille': '890 KB',
      'categorie': 'Académique',
      'url': 'https://exemple.com/programme-s3.pdf',
    },
    {
      'type': 'PDF',
      'titre': 'Cours Algo – Chap. 1',
      'date': '15/09/2025',
      'taille': '4.1 MB',
      'categorie': 'Cours',
      'url': 'https://exemple.com/cours-algo.pdf',
    },
    {
      'type': 'DOCX',
      'titre': 'Formulaire de demande',
      'date': '20/09/2025',
      'taille': '240 KB',
      'categorie': 'Formulaires',
      'url': 'https://exemple.com/formulaire.docx',
    },
    {
      'type': 'PDF',
      'titre': 'Calendrier des examens',
      'date': '22/09/2025',
      'taille': '350 KB',
      'categorie': 'Admin',
      'url': 'https://exemple.com/calendrier.pdf',
    },
    {
      'type': 'PDF',
      'titre': 'TP BDD – Exercices',
      'date': '28/09/2025',
      'taille': '1.8 MB',
      'categorie': 'Cours',
      'url': 'https://exemple.com/tp-bdd.pdf',
    },
  ];

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.initialCategory.clamp(
      0,
      categories.length - 1,
    );
  }

  List<Map<String, String>> get filteredDocuments {
    if (selectedCategory == 0) {
      return documents;
    }

    final String category = categories[selectedCategory];

    return documents
        .where(
          (document) => document['categorie'] == category,
    )
        .toList();
  }

  // ============================================================
  // OUVRIR LES DÉTAILS
  // ============================================================

  void openDocument(Map<String, String> document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentDetailPage(
          titre: document['titre'] ?? '',
          type: document['type'] ?? '',
          date: document['date'] ?? '',
          taille: document['taille'] ?? '',
        ),
      ),
    );
  }

  // ============================================================
  // OUVRIR / TÉLÉCHARGER LE DOCUMENT
  // ============================================================

  Future<void> downloadDocument(String url) async {
    if (url.trim().isEmpty) {
      _showMessage('URL du document invalide');
      return;
    }

    final Uri? uri = Uri.tryParse(url);

    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      _showMessage('URL du document invalide');
      return;
    }

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        _showMessage('Impossible d’ouvrir le document');
      }
    } catch (_) {
      _showMessage('Impossible d’ouvrir le document');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> visibleDocuments =
        filteredDocuments;

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
                    onPressed: () => Navigator.pop(context),
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
            // DOCUMENTS
            // ==================================================

            Expanded(
              child: visibleDocuments.isEmpty
                  ? const Center(
                child: Text(
                  'Aucun document disponible',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8797A7),
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  20,
                ),
                itemCount: visibleDocuments.length,
                itemBuilder: (context, index) {
                  final Map<String, String> document =
                  visibleDocuments[index];

                  return DocumentCard(
                    type: document['type'] ?? '',
                    titre: document['titre'] ?? '',
                    date: document['date'] ?? '',
                    taille: document['taille'] ?? '',
                    onView: () => openDocument(document),
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