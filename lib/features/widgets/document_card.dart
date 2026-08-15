import 'package:flutter/material.dart';

/// ============================================================
/// WIDGET : CARTE DOCUMENT
/// ============================================================

class DocumentCard extends StatelessWidget {
  final String type;
  final String titre;
  final String date;
  final String taille;
  final VoidCallback? onView;
  final VoidCallback? onDownload;

  const DocumentCard({
    super.key,
    required this.type,
    required this.titre,
    required this.date,
    required this.taille,
    this.onView,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE8EAED),
        ),
      ),
      child: Row(
        children: [
          // ----------------------------------------------------
          // TYPE DU DOCUMENT
          // ----------------------------------------------------

          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: type == 'DOCX'
                  ? const Color(0xFFE8F2FC)
                  : const Color(0xFFFCEBE8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              type,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: type == 'DOCX'
                    ? const Color(0xFF4D8BC9)
                    : const Color(0xFFD96B5F),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ----------------------------------------------------
          // INFORMATIONS DU DOCUMENT
          // ----------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$date · $taille',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ----------------------------------------------------
          // BOUTON VISUALISER
          // ----------------------------------------------------

          IconButton(
            onPressed: onView,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            icon: const Icon(
              Icons.visibility_outlined,
              size: 19,
              color: Color(0xFF5795C9),
            ),
          ),

          // ----------------------------------------------------
          // BOUTON TÉLÉCHARGER
          // ----------------------------------------------------

          IconButton(
            onPressed: onDownload,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            icon: const Icon(
              Icons.download_outlined,
              size: 19,
              color: Color(0xFF5795C9),
            ),
          ),
        ],
      ),
    );
  }
}