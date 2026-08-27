import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';
import 'resultat_detail_page.dart';

class MesResultatsPage extends StatelessWidget {
  const MesResultatsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Semestre 6 · 2025–2026',
            title: 'Résultats',
            subtitle: 'Publication du 25 août 2026',
            icon: Icons.assessment_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _ResultsSummary(),
                const SizedBox(height: 28),
                const AppSectionHeading(
                  title: 'Résultats par matière',
                  subtitle: 'Notes sur 20 · moyenne pondérée',
                ),
                const SizedBox(height: 14),
                AppSurface(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (
                        var i = 0;
                        i < AcademicCatalog.grades.length;
                        i++
                      ) ...[
                        _GradeRow(grade: AcademicCatalog.grades[i]),
                        if (i != AcademicCatalog.grades.length - 1)
                          Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: context.semanticColors.border,
                          ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Les couleurs indiquent uniquement le statut académique de la note.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
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

class _ResultsSummary extends StatelessWidget {
  const _ResultsSummary();
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: dark
              ? const [Color(0xFF10243A), Color(0xFF163B4E)]
              : const [AppColors.primaryStrong, Color(0xFF215B77)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'SYNTHÈSE DU SEMESTRE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .8,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: .22),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text(
                  'Semestre validé',
                  style: TextStyle(
                    color: Color(0xFF9BE0BE),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: _SummaryMetric(
                  value: '13,7',
                  suffix: '/20',
                  label: 'Moyenne',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _SummaryMetric(
                  value: '26',
                  suffix: '/30',
                  label: 'Crédits',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _SummaryMetric(
                  value: 'Bien',
                  suffix: '',
                  label: 'Mention',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  final String value, suffix, label;
  const _SummaryMetric({
    required this.value,
    required this.suffix,
    required this.label,
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            TextSpan(
              text: suffix,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
    ],
  );
}

class _GradeRow extends StatelessWidget {
  final AcademicGrade grade;
  const _GradeRow({required this.grade});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = grade.average >= 10
        ? context.semanticColors.success
        : grade.average >= 8
        ? context.semanticColors.warning
        : theme.colorScheme.error;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => ResultatDetailPage(grade: grade),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grade.subject,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Coef. ${grade.coefficient} · ${grade.credits} crédits',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    grade.average.toStringAsFixed(1).replaceAll('.', ','),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: color,
                      fontSize: 20,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  Text(
                    '/ 20',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textDisabled,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}
