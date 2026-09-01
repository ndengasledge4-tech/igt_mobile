import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';
import '../../app/theme/theme_mode_scope.dart';
import '../../shared/widgets/app_badge.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/app_header.dart';
import '../../shared/widgets/app_page.dart';
import '../../shared/widgets/app_section_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Paramètres',
        subtitle: 'Personnalisez votre expérience',
      ),
      body: AppPage(
        scrollable: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSectionHeader(
              title: 'Apparence',
              subtitle: 'Choisissez le rendu le plus confortable pour vous.',
            ),
            const SizedBox(height: AppDimensions.space16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.brightness_6_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: AppDimensions.space12),
                      Expanded(
                        child: Text(
                          'Thème de l’application',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const AppBadge(label: 'Local', tone: AppBadgeTone.info),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space16),
                  ValueListenableBuilder<ThemeMode>(
                    valueListenable: AppThemeModeScope.of(context),
                    builder: (context, mode, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<ThemeMode>(
                          key: const Key('theme-mode-selector'),
                          showSelectedIcon: false,
                          segments: const [
                            ButtonSegment(
                              value: ThemeMode.light,
                              icon: Icon(Icons.light_mode_outlined),
                              label: Text('Clair'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              icon: Icon(Icons.dark_mode_outlined),
                              label: Text('Sombre'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.system,
                              icon: Icon(Icons.settings_suggest_outlined),
                              label: Text('Système'),
                            ),
                          ],
                          selected: {mode},
                          onSelectionChanged: (selection) {
                            AppThemeModeScope.of(context).value =
                                selection.first;
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  Text(
                    'Ce choix reste volontairement en mémoire locale uniquement pendant cette session.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
