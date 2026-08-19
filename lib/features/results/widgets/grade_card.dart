import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';

class GradeCard extends StatelessWidget {
  const GradeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final success = context.semanticColors.success;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: .05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "Note Finale",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "15.5 /20",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: success,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: success.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Mention : Bien",
                style: TextStyle(color: success, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 24),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: 15.5 / 20,
                minHeight: 8,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation(success),
              ),
            ),

            const SizedBox(height: 10),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0", style: TextStyle(color: Colors.grey)),
                Text("20", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
