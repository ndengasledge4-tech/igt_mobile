import 'package:flutter/material.dart';

import '../../app/theme/semantic_colors.dart';

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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre du bloc.
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: context.semanticColors.textPrimary,
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
                            color: context.semanticColors.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Valeur de l'information.
                      Expanded(
                        child: Text(
                          item['value'] ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: context.semanticColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Séparateur entre les informations.
                if (index < items.length - 1)
                  Divider(height: 1, color: context.semanticColors.border),
              ],
            );
          }),
        ],
      ),
    );
  }
}
