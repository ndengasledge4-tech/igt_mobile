import 'package:flutter/material.dart';

import '../../app/theme/semantic_colors.dart';

class EmploiDuTempsCard extends StatelessWidget {
  final String heure;
  final String matiere;
  final String details;
  final Color couleur;
  final VoidCallback? onTap;

  const EmploiDuTempsCard({
    super.key,
    required this.heure,
    required this.matiere,
    required this.details,
    required this.couleur,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 68,
              child: Text(
                heure,
                style: TextStyle(
                  color: context.semanticColors.textSecondary,
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: couleur, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      matiere,
                      style: TextStyle(
                        color: context.semanticColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      details,
                      style: TextStyle(
                        color: context.semanticColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
