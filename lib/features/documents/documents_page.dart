import 'package:flutter/material.dart';

import '../../mock/mock_documents.dart';
import 'widgets/category_filter.dart';
import 'widgets/document_card.dart';
import 'widgets/documents_header.dart';
import 'widgets/search_document.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const DocumentsHeader(),

            const SizedBox(height: 20),

            const SearchDocument(),

            const SizedBox(height: 16),

            const CategoryFilter(),

            const SizedBox(height: 20),
            for (final document in MockDocumentsData.items) ...[
              DocumentCard(
                type: document.fileType,
                title: document.title,
                size: document.size,
                date: document.updatedAt,
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
