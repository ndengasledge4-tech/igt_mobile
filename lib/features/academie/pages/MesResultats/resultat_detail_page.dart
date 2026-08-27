import 'package:flutter/material.dart';

import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';

class ResultatDetailPage extends StatelessWidget {
  final String semestre;
  final String moyenne;
  final String credits;
  final String mention;
  final AcademicGrade? grade;
  const ResultatDetailPage({
    super.key,
    this.semestre = 'Semestre 6',
    this.moyenne = '15.30',
    this.credits = '5',
    this.mention = 'Bien',
    this.grade,
  });

  AcademicGrade get _grade => grade ?? AcademicCatalog.grades.first;
  @override
  Widget build(BuildContext context) {
    final item = _grade;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppScreenHeader(
              eyebrow: semestre,
              title: item.subject,
              subtitle: item.teacher,
              icon: Icons.analytics_rounded,
              showBack: true,
            ),
          ),
          SliverToBoxAdapter(
            child: AppResponsiveContent(
              maxWidth: 720,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSurface(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _PrimaryGrade(value: item.average)),
                            const SizedBox(width: 16),
                            _SmallMetric(
                              label: 'Coefficient',
                              value: '${item.coefficient}',
                            ),
                            const SizedBox(width: 10),
                            _SmallMetric(
                              label: 'Crédits',
                              value: '${item.credits}',
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Divider(color: context.semanticColors.border),
                        const SizedBox(height: 12),
                        _GradeLine(
                          label: 'Contrôle continu',
                          value: item.continuous,
                        ),
                        const SizedBox(height: 14),
                        _GradeLine(
                          label: 'Travaux pratiques',
                          value: item.practical,
                        ),
                        const SizedBox(height: 14),
                        _GradeLine(label: 'Examen', value: item.exam),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const AppSectionHeading(title: 'Commentaire pédagogique'),
                  const SizedBox(height: 12),
                  AppSurface(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.comment,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(height: 1.55),
                          ),
                        ),
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
}

class _PrimaryGrade extends StatelessWidget {
  final double value;
  const _PrimaryGrade({required this.value});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MOYENNE',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
            fontWeight: FontWeight.w700,
            letterSpacing: .7,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value.toStringAsFixed(1).replaceAll('.', ','),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 34,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              TextSpan(
                text: ' / 20',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SmallMetric extends StatelessWidget {
  final String label, value;
  const _SmallMetric({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    width: 82,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 3),
        Text(
          label,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
        ),
      ],
    ),
  );
}

class _GradeLine extends StatelessWidget {
  final String label;
  final double value;
  const _GradeLine({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ),
      Text(
        value.toStringAsFixed(1).replaceAll('.', ','),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 17,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
      Text(
        ' / 20',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.semanticColors.textSecondary,
        ),
      ),
    ],
  );
}
