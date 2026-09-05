import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';

class AcademiePage extends StatelessWidget {
  const AcademiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: AppScreenHeader(
              eyebrow: 'Votre cursus',
              title: 'Académique',
              subtitle: 'Licence 3 · Génie Informatique',
              icon: Icons.school_rounded,
            ),
          ),
          SliverToBoxAdapter(
            child: AppResponsiveContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SemesterHero(),
                  const SizedBox(height: 28),
                  const AppSectionHeading(
                    title: 'Vos essentiels',
                    subtitle: 'Accédez rapidement à votre quotidien étudiant',
                  ),
                  const SizedBox(height: 14),
                  const _PrimaryDestinations(),
                  const SizedBox(height: 28),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const subjects = _SubjectsSection();
                      const aside = Column(
                        children: [
                          _NextLesson(),
                          SizedBox(height: 14),
                          _ResultsSnapshot(),
                        ],
                      );
                      if (constraints.maxWidth < 720) {
                        return const Column(
                          children: [subjects, SizedBox(height: 20), aside],
                        );
                      }
                      return const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: subjects),
                          SizedBox(width: 20),
                          Expanded(flex: 4, child: aside),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const AppSectionHeading(
                    title: 'Parcours et ressources',
                    subtitle: 'Suivez votre cursus et retrouvez vos contenus',
                  ),
                  const SizedBox(height: 14),
                  const _ResourcePanel(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SemesterHero extends StatelessWidget {
  const _SemesterHero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      constraints: const BoxConstraints(minHeight: 210),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF10243A), Color(0xFF163B4E)]
              : const [AppColors.primaryStrong, Color(0xFF215B77)],
        ),
        borderRadius: BorderRadius.circular(26),
        border: isDark
            ? Border.all(color: Colors.white.withValues(alpha: 0.07))
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryStrong.withValues(
              alpha: isDark ? 0.18 : 0.2,
            ),
            blurRadius: 30,
            offset: const Offset(0, 13),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -38,
            top: -50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 28,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: const Text(
                        'SEMESTRE 6',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '2025–2026',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.72),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Votre semestre en mouvement',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '13 semaines validées sur 18',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: _HeroMetric(value: '72 %', label: 'Progression'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _HeroMetric(value: '14,8', label: 'Moyenne'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _HeroMetric(value: '26/30', label: 'Crédits'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  final String value;
  final String label;

  const _HeroMetric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.62),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryDestinations extends StatelessWidget {
  const _PrimaryDestinations();

  @override
  Widget build(BuildContext context) {
    final items = [
      _DestinationData(
        'Mes cours',
        '6 matières',
        Icons.menu_book_rounded,
        AppColors.secondary,
        () => Navigator.pushNamed(context, RouteNames.mesCours),
      ),
      _DestinationData(
        'Résultats',
        'Moyennes et crédits',
        Icons.workspace_premium_rounded,
        AppColors.accent,
        () => Navigator.pushNamed(context, RouteNames.mesResultats),
      ),
      _DestinationData(
        'Planning',
        'Cette semaine',
        Icons.calendar_month_rounded,
        const Color(0xFFD47A45),
        () => Navigator.pushNamed(context, RouteNames.emploiDuTemps),
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 680 ? 3 : 1;
        const gap = 12.0;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: _DestinationTile(item: item),
              ),
          ],
        );
      },
    );
  }
}

class _DestinationTile extends StatelessWidget {
  final _DestinationData item;

  const _DestinationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return AppSurface(
      onTap: item.onTap,
      padding: const EdgeInsets.all(14),
      radius: 18,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: isDark ? 0.18 : 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: item.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: theme.textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_rounded,
            size: 18,
            color: context.semanticColors.textDisabled,
          ),
        ],
      ),
    );
  }
}

class _SubjectsSection extends StatelessWidget {
  const _SubjectsSection();

  static const _subjects = [
    _SubjectData(
      'Architecture logicielle',
      'Pr. Mariam Diarra',
      0.82,
      AppColors.secondary,
    ),
    _SubjectData(
      'Sécurité des réseaux',
      'Dr. Alain Mavoungou',
      0.68,
      Color(0xFF6076A8),
    ),
    _SubjectData(
      'Bases de données avancées',
      'Pr. Inès Moukoko',
      0.76,
      Color(0xFF7C6798),
    ),
    _SubjectData(
      'Entrepreneuriat',
      'Mme. Grâce Nsona',
      0.61,
      Color(0xFFD47A45),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeading(
          title: 'Matières en cours',
          subtitle: 'Progression des contenus du semestre',
        ),
        const SizedBox(height: 14),
        AppSurface(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              for (var index = 0; index < _subjects.length; index++) ...[
                _SubjectRow(subject: _subjects[index]),
                if (index != _subjects.length - 1)
                  Divider(height: 1, color: context.semanticColors.border),
              ],
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () => Navigator.pushNamed(context, RouteNames.mesCours),
          icon: const Icon(Icons.add_rounded, size: 18),
          label: const Text('Voir les 2 autres matières'),
        ),
      ],
    );
  }
}

class _SubjectRow extends StatelessWidget {
  final _SubjectData subject;

  const _SubjectRow({required this.subject});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 44,
            decoration: BoxDecoration(
              color: subject.color,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  subject.teacher,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${(subject.progress * 100).round()} %',
            style: theme.textTheme.bodySmall?.copyWith(
              color: subject.color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _NextLesson extends StatelessWidget {
  const _NextLesson();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A211D) : const Color(0xFFFFF5EC),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark ? const Color(0xFF50372B) : const Color(0xFFF2D7C5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                color: Color(0xFFD47A45),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Prochain cours',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '10h15',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD47A45),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text('Architecture logicielle', style: theme.textTheme.titleMedium),
          const SizedBox(height: 7),
          Text(
            'Salle B12 · Pr. Mariam Diarra',
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.semanticColors.textSecondary,
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, RouteNames.emploiDuTemps),
            icon: const Icon(Icons.calendar_today_rounded, size: 17),
            label: const Text('Ouvrir le planning'),
          ),
        ],
      ),
    );
  }
}

class _ResultsSnapshot extends StatelessWidget {
  const _ResultsSnapshot();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppSurface(
      onTap: () => Navigator.pushNamed(context, RouteNames.mesResultats),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Résultats', style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  '+0,6 point ce semestre',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '14,8',
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourcePanel extends StatelessWidget {
  const _ResourcePanel();

  static const _links = [
    _ResourceData(
      'Mon parcours',
      'Licence 3 · Semestre 6',
      Icons.route_rounded,
      AppColors.primaryLight,
      RouteNames.monParcours,
    ),
    _ResourceData(
      'Mes notes',
      'Évaluations et coefficients',
      Icons.edit_note_rounded,
      Color(0xFF7C6798),
      RouteNames.mesNotes,
    ),
    _ResourceData(
      'Cours et ressources',
      'Supports et documents récents',
      Icons.folder_copy_rounded,
      AppColors.secondary,
      RouteNames.mesDocuments,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          for (var index = 0; index < _links.length; index++) ...[
            _ResourceRow(data: _links[index]),
            if (index != _links.length - 1)
              Divider(height: 1, color: context.semanticColors.border),
          ],
        ],
      ),
    );
  }
}

class _ResourceRow extends StatelessWidget {
  final _ResourceData data;

  const _ResourceRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, data.route),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: data.color.withValues(alpha: isDark ? 0.18 : 0.1),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(data.icon, color: data.color, size: 21),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 3),
                  Text(
                    data.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: context.semanticColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DestinationData(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.onTap,
  );
}

class _SubjectData {
  final String title;
  final String teacher;
  final double progress;
  final Color color;

  const _SubjectData(this.title, this.teacher, this.progress, this.color);
}

class _ResourceData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  const _ResourceData(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.route,
  );
}
