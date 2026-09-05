import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';

class AcademicMenu extends StatelessWidget {
  const AcademicMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "RUBRIQUES",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 16),

          _AcademicCard(
            icon: Icons.bar_chart_rounded,
            iconColor: const Color(0xFF2563EB),
            background: const Color(0xFFEAF2FF),
            title: "Résultats & Notes",
            subtitle: "Consultez vos notes, moyennes et crédits.",
            onTap: () {
              Navigator.pushNamed(context, RouteNames.results);
            },
          ),

          const SizedBox(height: 16),

          _AcademicCard(
            icon: Icons.schedule_rounded,
            iconColor: const Color(0xFF16A34A),
            background: const Color(0xFFEAFBF2),
            title: "Emploi du temps",
            subtitle: "Consultez votre planning hebdomadaire.",
            onTap: () {
              Navigator.pushNamed(context, RouteNames.timetable);
            },
          ),
        ],
      ),
    );
  }
}

class _AcademicCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color background;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AcademicCard({
    required this.icon,
    required this.iconColor,
    required this.background,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 30),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
