import 'package:flutter/material.dart';

/// Carte contenant les informations académiques de l'étudiant.
class ParcoursAcademiqueCard extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;

  const ParcoursAcademiqueCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre du bloc.
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Liste des informations académiques.
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom de l'information.
                      Expanded(
                        child: Text(
                          item['label'] ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Valeur de l'information.
                      Expanded(
                        child: Text(
                          item['value'] ?? '',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Séparateur entre les informations.
                if (index < items.length - 1)
                  Divider(
                    height: 1,
                    color: Colors.grey.shade200,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}