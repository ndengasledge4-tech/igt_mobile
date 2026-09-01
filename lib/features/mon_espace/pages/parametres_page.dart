import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../app/theme/theme_mode_scope.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../widgets/logout_bottom_sheet.dart';

class ParametresPage extends StatelessWidget {
  const ParametresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Paramètres',
        subtitle: 'Apparence, compte et confidentialité',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSectionHeading(
                title: 'Apparence',
                subtitle: 'Choisissez le thème le plus confortable.',
              ),
              const SizedBox(height: 14),
              const _ThemeCard(),
              const SizedBox(height: 28),
              const AppSectionHeading(
                title: 'Compte et sécurité',
                subtitle: 'Gérez vos informations et vos accès.',
              ),
              const SizedBox(height: 14),
              _SettingsGroup(
                items: [
                  _SettingData(
                    icon: Icons.person_outline_rounded,
                    title: 'Informations personnelles',
                    subtitle: 'Coordonnées et identité',
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.profil),
                  ),
                  _SettingData(
                    icon: Icons.password_rounded,
                    title: 'Modifier le mot de passe',
                    subtitle: 'Sécuriser votre connexion',
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.modifierMotDePasse,
                    ),
                  ),
                  _SettingData(
                    icon: Icons.shield_outlined,
                    title: 'Sécurité du compte',
                    subtitle: 'Récupération et vérifications',
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.securiteCompte),
                  ),
                  _SettingData(
                    icon: Icons.devices_rounded,
                    title: 'Sessions actives',
                    subtitle: 'Appareils connectés',
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.sessionsActives,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const AppSectionHeading(
                title: 'Application',
                subtitle: 'Notifications et informations du produit.',
              ),
              const SizedBox(height: 14),
              _SettingsGroup(
                items: [
                  _SettingData(
                    icon: Icons.notifications_none_rounded,
                    title: 'Préférences de notifications',
                    subtitle: 'Alertes et communications',
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.notificationsPreferences,
                    ),
                  ),
                  _SettingData(
                    icon: Icons.gavel_outlined,
                    title: 'Informations légales',
                    subtitle: 'Confidentialité et conditions',
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.informationsLegales,
                    ),
                  ),
                  _SettingData(
                    icon: Icons.info_outline_rounded,
                    title: 'À propos',
                    subtitle: 'Version 1.0.0 · IGT Mobile',
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.aPropos),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              AppSurface(
                color: Theme.of(context).colorScheme.errorContainer,
                onTap: () => _showLogoutBottomSheet(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Se déconnecter',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => const LogoutBottomSheet(),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  const _ThemeCard();

  @override
  Widget build(BuildContext context) {
    final notifier = AppThemeModeScope.of(context);
    return AppSurface(
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: notifier,
        builder: (context, mode, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      _iconFor(mode),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thème de l’application',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Le changement est appliqué immédiatement.',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: context.semanticColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                key: const Key('theme-mode-selector'),
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ThemeChoice(
                    label: 'Clair',
                    icon: Icons.light_mode_outlined,
                    value: ThemeMode.light,
                    selected: mode == ThemeMode.light,
                    onSelected: () => notifier.value = ThemeMode.light,
                  ),
                  _ThemeChoice(
                    label: 'Sombre',
                    icon: Icons.dark_mode_outlined,
                    value: ThemeMode.dark,
                    selected: mode == ThemeMode.dark,
                    onSelected: () => notifier.value = ThemeMode.dark,
                  ),
                  _ThemeChoice(
                    label: 'Système',
                    icon: Icons.settings_suggest_outlined,
                    value: ThemeMode.system,
                    selected: mode == ThemeMode.system,
                    onSelected: () => notifier.value = ThemeMode.system,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Ce réglage reste local à cette session du prototype.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textDisabled,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _iconFor(ThemeMode mode) => switch (mode) {
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
    ThemeMode.system => Icons.settings_suggest_outlined,
  };
}

class _ThemeChoice extends StatelessWidget {
  final String label;
  final IconData icon;
  final ThemeMode value;
  final bool selected;
  final VoidCallback onSelected;

  const _ThemeChoice({
    required this.label,
    required this.icon,
    required this.value,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      key: ValueKey('theme-${value.name}'),
      avatar: Icon(icon, size: 17),
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => onSelected(),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<_SettingData> items;

  const _SettingsGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _SettingTile(data: items[index]),
            if (index != items.length - 1)
              Divider(
                height: 1,
                indent: 68,
                color: context.semanticColors.border,
              ),
          ],
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final _SettingData data;

  const _SettingTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: data.onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.primarySoft.withValues(
            alpha: Theme.of(context).brightness == Brightness.dark ? 0.12 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(data.icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(data.title),
      subtitle: Text(data.subtitle),
      trailing: data.onTap == null
          ? null
          : Icon(
              Icons.chevron_right_rounded,
              color: context.semanticColors.textDisabled,
            ),
    );
  }
}

class _SettingData {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _SettingData({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}
