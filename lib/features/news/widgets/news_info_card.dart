import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';

class NewsInfoCard extends StatelessWidget {
  const NewsInfoCard({super.key});

  Widget buildItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: context.semanticColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          buildItem(
            context,
            Icons.calendar_today_outlined,
            "28 Juillet 2025 à 10h00",
          ),

          buildItem(
            context,
            Icons.location_on_outlined,
            "Amphithéâtre Principal, Campus IGT",
          ),

          buildItem(context, Icons.people_outline, "312 étudiants intéressés"),
        ],
      ),
    );
  }
}
