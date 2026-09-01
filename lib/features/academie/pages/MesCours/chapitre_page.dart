import 'package:flutter/material.dart';

import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';
import '../../widgets/academic_components.dart';

class ChapitrePage extends StatelessWidget {
  final String titre;
  final String numero;
  final String contenu;
  final List<String> objectifs;
  const ChapitrePage({
    super.key,
    required this.titre,
    required this.numero,
    required this.contenu,
    required this.objectifs,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Chapitre $numero',
            title: titre,
            subtitle: 'Architecture logicielle',
            icon: Icons.auto_stories_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            maxWidth: 760,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSurface(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          AcademicStatusBadge(
                            status: LearningStatus.inProgress,
                          ),
                          Spacer(),
                          Text(
                            '65 %',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const LinearProgressIndicator(value: .65, minHeight: 7),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 18,
                        runSpacing: 8,
                        children: [
                          _ChapterMeta(
                            icon: Icons.schedule_rounded,
                            label: '25 min de lecture',
                          ),
                          _ChapterMeta(
                            icon: Icons.attach_file_rounded,
                            label: '6 ressources',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const AppSectionHeading(title: 'Présentation'),
                const SizedBox(height: 10),
                Text(
                  contenu,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.65,
                    color: context.semanticColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 26),
                const AppSectionHeading(title: 'Objectifs pédagogiques'),
                const SizedBox(height: 12),
                AppSurface(
                  child: Column(
                    children: [
                      for (var i = 0; i < objectifs.length; i++) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: .1),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  objectifs[i],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (i != objectifs.length - 1)
                          const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _ChapterMeta extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ChapterMeta({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 17, color: context.semanticColors.textSecondary),
      const SizedBox(width: 6),
      Flexible(child: Text(label)),
    ],
  );
}
