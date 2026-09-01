import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';

class NewsDescription extends StatelessWidget {
  const NewsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "La grande cérémonie de remise des diplômes de la promotion 2025 aura lieu à l'Amphithéâtre principal de l'IGT. Les diplômés sont priés de se présenter en tenue de cérémonie avant 09h00. Les familles sont les bienvenues. Des places limitées sont disponibles sur réservation. Merci de contacter le service scolarité pour toute information complémentaire.",
      style: TextStyle(
        fontSize: 15,
        color: context.semanticColors.textSecondary,
        height: 1.8,
      ),
    );
  }
}
