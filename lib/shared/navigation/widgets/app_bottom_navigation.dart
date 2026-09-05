import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';

const _destinations = [
  _NavigationDestination(icon: Icons.home_rounded, label: 'Accueil'),
  _NavigationDestination(icon: Icons.newspaper_rounded, label: 'Actualités'),
  _NavigationDestination(icon: Icons.school_rounded, label: 'Académique'),
  _NavigationDestination(icon: Icons.description_rounded, label: 'Documents'),
  _NavigationDestination(icon: Icons.person_rounded, label: 'Profil'),
];

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(
            alpha: isDark ? 0.98 : 0.96,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: context.semanticColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.09),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Row(
            children: [
              for (var index = 0; index < _destinations.length; index++)
                Expanded(
                  child: _NavigationItem(
                    destination: _destinations[index],
                    selected: currentIndex == index,
                    onTap: () => onDestinationSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final _NavigationDestination destination;
  final bool selected;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected
        ? theme.colorScheme.primary
        : context.semanticColors.textDisabled;

    return Semantics(
      button: true,
      selected: selected,
      label: destination.label,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: selected
                  ? (theme.brightness == Brightness.dark
                        ? theme.colorScheme.primary.withValues(alpha: 0.14)
                        : AppColors.primarySoft)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(destination.icon, size: 22, color: color),
                const SizedBox(height: 4),
                Text(
                  destination.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontSize: 12,
                    height: 1,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppNavigationRail extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool extended;

  const AppNavigationRail({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.extended = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(right: BorderSide(color: context.semanticColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.16 : 0.045),
            blurRadius: 24,
            offset: const Offset(8, 0),
          ),
        ],
      ),
      child: SafeArea(
        child: NavigationRail(
          extended: extended,
          minWidth: 92,
          minExtendedWidth: 210,
          backgroundColor: Colors.transparent,
          selectedIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
          labelType: extended
              ? NavigationRailLabelType.none
              : NavigationRailLabelType.all,
          groupAlignment: -0.25,
          indicatorColor: isDark
              ? theme.colorScheme.primary.withValues(alpha: 0.16)
              : AppColors.primarySoft,
          leading: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 22),
            child: Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryStrong, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'IGT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          destinations: [
            for (final destination in _destinations)
              NavigationRailDestination(
                icon: Icon(destination.icon),
                selectedIcon: Icon(destination.icon),
                label: Text(
                  destination.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavigationDestination {
  final IconData icon;
  final String label;

  const _NavigationDestination({required this.icon, required this.label});
}
