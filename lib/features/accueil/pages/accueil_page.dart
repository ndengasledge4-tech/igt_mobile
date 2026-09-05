import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../../communication/communication_store.dart';

class AccueilPage extends StatelessWidget {
  final ValueChanged<int>? onNavigate;

  const AccueilPage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width < 360
        ? 16.0
        : width >= 600
        ? 32.0
        : 20.0;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: CommunicationStore.instance,
              builder: (context, _) => AppStudentHeader(
                greeting: 'Bonjour, Aymen',
                identity: 'Génie Informatique · Licence 3',
                initials: 'AM',
                notificationCount:
                    CommunicationStore.instance.unreadNotifications,
                secondaryAction: IconButton(
                  tooltip: 'Profil enseignant (démo)',
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteNames.teacherHome),
                  icon: const Icon(Icons.switch_account_outlined),
                ),
                onNotifications: () =>
                    Navigator.pushNamed(context, RouteNames.notifications),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.maxContentWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    20,
                    horizontalPadding,
                    36,
                  ),
                  child: _DashboardContent(
                    isTablet: width >= 600,
                    onNavigate: onNavigate,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final bool isTablet;
  final ValueChanged<int>? onNavigate;

  const _DashboardContent({required this.isTablet, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final primaryColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _AcademicHeroCard(),
        const SizedBox(height: 28),
        const _SectionTitle(
          title: 'Accès rapides',
          subtitle: 'Vos essentiels académiques',
        ),
        const SizedBox(height: 14),
        _QuickActions(onNavigate: onNavigate),
        const SizedBox(height: 28),
        const _SectionTitle(
          title: 'Prochain cours',
          subtitle: 'Votre agenda aujourd’hui',
        ),
        const SizedBox(height: 14),
        const _NextClassCard(),
        const SizedBox(height: 28),
        const _SectionTitle(title: 'Résumé académique', subtitle: 'Semestre 6'),
        const SizedBox(height: 14),
        const _AcademicSummary(),
      ],
    );

    final editorialColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          title: 'À la une',
          subtitle: 'La vie de votre institut',
          action: 'Tout voir',
          onAction: () => onNavigate?.call(1),
        ),
        const SizedBox(height: 14),
        const _NewsFeatureCard(),
        const SizedBox(height: 28),
        const _SectionTitle(
          title: 'À venir',
          subtitle: 'Un rendez-vous à ne pas manquer',
        ),
        const SizedBox(height: 14),
        const _UpcomingEventCard(),
      ],
    );

    if (!isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [primaryColumn, const SizedBox(height: 28), editorialColumn],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 6, child: primaryColumn),
        const SizedBox(width: 24),
        Expanded(flex: 4, child: editorialColumn),
      ],
    );
  }
}

class _AcademicHeroCard extends StatelessWidget {
  const _AcademicHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 218),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryStrong, Color(0xFF174D70)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryStrong.withValues(alpha: 0.22),
            blurRadius: 30,
            offset: const Offset(0, 13),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const Positioned(
            right: -36,
            top: -42,
            child: _DecorativeRing(size: 170),
          ),
          const Positioned(
            right: 55,
            bottom: -62,
            child: _DecorativeRing(size: 130),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.17),
                        ),
                      ),
                      child: const Text(
                        'LICENCE 3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    const _StatusBadge(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Génie Informatique',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Semestre 6  ·  Année 2025–2026',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.76),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: 0.72,
                          minHeight: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.14),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF79C4BC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    const Text(
                      '72 %',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Progression du semestre',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final ValueChanged<int>? onNavigate;

  const _QuickActions({this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(
        'Résultats',
        'Notes et crédits',
        Icons.workspace_premium_rounded,
        const Color(0xFF3F6F96),
        () => Navigator.pushNamed(context, RouteNames.mesResultats),
      ),
      _QuickActionData(
        'Emploi du temps',
        'Cours de la semaine',
        Icons.calendar_month_rounded,
        const Color(0xFF2F7D78),
        () => Navigator.pushNamed(context, RouteNames.emploiDuTemps),
      ),
      _QuickActionData(
        'Documents',
        'Ressources utiles',
        Icons.description_rounded,
        const Color(0xFF7A668D),
        () => onNavigate != null
            ? onNavigate!(3)
            : Navigator.pushNamed(context, RouteNames.mesDocuments),
      ),
      _QuickActionData(
        'Messages',
        'Échanges et demandes',
        Icons.forum_rounded,
        const Color(0xFFB06F42),
        () => Navigator.pushNamed(context, RouteNames.messagerie),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = constraints.maxWidth < 360 ? 10.0 : 12.0;
        final itemWidth = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final action in actions)
              SizedBox(
                width: itemWidth,
                child: _QuickActionCard(data: action),
              ),
          ],
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final _QuickActionData data;

  const _QuickActionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.semanticColors;
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.border.withValues(alpha: 0.85)),
      ),
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: isDark ? 0.18 : 0.1),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(data.icon, color: data.color, size: 22),
              ),
              const SizedBox(height: 15),
              Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 3),
              Text(
                data.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextClassCard extends StatelessWidget {
  const _NextClassCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.semanticColors;
    return Container(
      decoration: _surfaceDecoration(context, radius: 22),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 6,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(22),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Text(
                            'COURS',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Dans 45 min',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Architecture logicielle',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Wrap(
                      spacing: 14,
                      runSpacing: 8,
                      children: [
                        _Meta(
                          icon: Icons.schedule_rounded,
                          text: '10h15 – 12h15',
                        ),
                        _Meta(
                          icon: Icons.location_on_rounded,
                          text: 'Salle B12',
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          size: 17,
                          color: colors.textDisabled,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Pr. Mariam Diarra',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ),
                      ],
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

class _AcademicSummary extends StatelessWidget {
  const _AcademicSummary();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('14,8', 'Moyenne', Icons.trending_up_rounded, AppColors.secondary),
      ('26/30', 'Crédits', Icons.stars_rounded, AppColors.accent),
      ('6', 'Matières', Icons.menu_book_rounded, AppColors.primaryLight),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: _surfaceDecoration(context, radius: 22),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            Expanded(
              child: _SummaryItem(
                value: items[i].$1,
                label: items[i].$2,
                icon: items[i].$3,
                color: items[i].$4,
              ),
            ),
            if (i != items.length - 1)
              SizedBox(
                height: 46,
                child: VerticalDivider(color: context.semanticColors.border),
              ),
          ],
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _SummaryItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 7),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 19,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _NewsFeatureCard extends StatelessWidget {
  const _NewsFeatureCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: _surfaceDecoration(context, radius: 24),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/news/news1.png', fit: BoxFit.cover),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0x990B2942)],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Text(
                      'CAMPUS',
                      style: TextStyle(
                        color: AppColors.primaryStrong,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'La nouvelle médiathèque ouvre ses portes',
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 8),
                Text(
                  'Un nouvel espace calme, connecté et pensé pour vos projets.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '18 août 2026  ·  3 min',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textDisabled,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingEventCard extends StatelessWidget {
  const _UpcomingEventCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceElevated : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: context.semanticColors.border),
            ),
            child: const Column(
              children: [
                Text(
                  '24',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'AOÛT',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forum des métiers du numérique',
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 7),
                const _Meta(
                  icon: Icons.schedule_rounded,
                  text: '09h00 – 16h00',
                ),
                const SizedBox(height: 5),
                const _Meta(
                  icon: Icons.location_on_rounded,
                  text: 'Amphithéâtre IGT',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? action;
  final VoidCallback? onAction;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!)),
      ],
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: context.semanticColors.textDisabled),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.semanticColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF79C4BC).withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(99),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFF79C4BC),
              shape: BoxShape.circle,
            ),
            child: SizedBox(width: 6, height: 6),
          ),
          SizedBox(width: 7),
          Text(
            'En cours',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeRing extends StatelessWidget {
  final double size;

  const _DecorativeRing({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 24,
        ),
      ),
    );
  }
}

class _QuickActionData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionData(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.onTap,
  );
}

BoxDecoration _surfaceDecoration(BuildContext context, {double radius = 20}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: context.semanticColors.border),
    boxShadow: isDark
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ]
        : [
            BoxShadow(
              color: AppColors.primaryStrong.withValues(alpha: 0.065),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
  );
}
