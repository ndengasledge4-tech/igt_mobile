import 'package:flutter/material.dart';

import 'widgets/category_filter.dart';
import 'widgets/document_card.dart';
import 'widgets/documents_header.dart';
import 'widgets/search_document.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            DocumentsHeader(),

            SizedBox(height: 20),

            SearchDocument(),

            SizedBox(height: 16),

            CategoryFilter(),

            SizedBox(height: 20),

            DocumentCard(
              type: "PDF",
              title: "Polycopié Algorithmique S2",
              size: "3.2 Mo",
              date: "20 Juil. 2025",
            ),

            SizedBox(height: 12),

            DocumentCard(
              type: "PDF",
              title: "Cours Base de Données — Chapitre 3",
              size: "1.8 Mo",
              date: "18 Juil. 2025",
            ),

            SizedBox(height: 12),

            DocumentCard(
              type: "PDF",
              title: "Calendrier des examens S2 2025",
              size: "240 Ko",
              date: "15 Juil. 2025",
            ),

            SizedBox(height: 12),

            DocumentCard(
              type: "PDF",
              title: "Règlement intérieur IGT 2025",
              size: "510 Ko",
              date: "10 Juil. 2025",
            ),

            SizedBox(height: 12),

            DocumentCard(
              type: "PPTX",
              title: "Support Marketing Digital — CM3",
              size: "4.8 Mo",
              date: "08 Juil. 2025",
            ),
          ],
        ),
      ),
    );
  }
}
