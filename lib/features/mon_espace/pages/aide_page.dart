import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class AidePage extends StatelessWidget {
  const AidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Aide et assistance',
        subtitle: 'Trouvez rapidement une réponse',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSurface(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Row(
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      size: 34,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Comment pouvons-nous vous aider ?',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Consultez les sujets fréquents ou contactez le service étudiant.',
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
              ),
              const SizedBox(height: 28),
              const AppSectionHeading(
                title: 'Questions fréquentes',
                subtitle: 'Les réponses aux besoins les plus courants.',
              ),
              const SizedBox(height: 14),
              AppSurface(
                padding: EdgeInsets.zero,
                child: Column(
                  children: const [
                    _HelpTile(
                      icon: Icons.lock_reset_rounded,
                      title: 'Accès et mot de passe',
                      subtitle: 'Récupération et sécurité du compte',
                    ),
                    Divider(height: 1, indent: 66),
                    _HelpTile(
                      icon: Icons.school_outlined,
                      title: 'Cours, notes et résultats',
                      subtitle: 'Comprendre les données académiques',
                    ),
                    Divider(height: 1, indent: 66),
                    _HelpTile(
                      icon: Icons.description_outlined,
                      title: 'Documents',
                      subtitle: 'Recherche et téléchargement',
                    ),
                    Divider(height: 1, indent: 66),
                    _HelpTile(
                      icon: Icons.payments_outlined,
                      title: 'Paiements',
                      subtitle: 'Situation financière et historique',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const AppSectionHeading(title: 'Contacter l’IGT'),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth >= 600
                      ? (constraints.maxWidth - 12) / 2
                      : constraints.maxWidth;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: itemWidth,
                        child: _ContactCard(
                          icon: Icons.mail_outline_rounded,
                          title: 'Service étudiant',
                          value: 'support@igt.edu',
                          onTap: () => _openSupportEmail(context),
                        ),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: const _ContactCard(
                          icon: Icons.schedule_rounded,
                          title: 'Disponibilité',
                          value: 'Lun–Ven · 08h–17h',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openSupportEmail(BuildContext context) async {
    final opened = await launchUrl(Uri.parse('mailto:support@igt.edu'));
    if (opened || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Aucune application de messagerie n’est disponible.'),
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HelpTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: () => _showHelp(context),
    leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: Icon(
      Icons.chevron_right_rounded,
      color: context.semanticColors.textDisabled,
    ),
  );

  void _showHelp(BuildContext context) {
    final answer = switch (title) {
      'Accès et mot de passe' =>
        'Utilisez « Mot de passe oublié » depuis la connexion, puis saisissez le code de vérification reçu.',
      'Cours, notes et résultats' =>
        'Les contenus académiques sont regroupés dans l’onglet Académique. Les données affichées sont celles du prototype local.',
      'Documents' =>
        'Recherchez un document par titre ou service, ouvrez son aperçu puis lancez le téléchargement simulé.',
      _ =>
        'La situation financière et l’historique des versements sont consultables depuis votre profil.',
    };
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 4, 22, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 14),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                answer,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.semanticColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('J’ai compris'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => AppSurface(
    onTap: onTap,
    child: Row(
      children: [
        Icon(icon, color: AppColors.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 3),
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (onTap != null)
          Icon(
            Icons.open_in_new_rounded,
            size: 18,
            color: context.semanticColors.textDisabled,
          ),
      ],
    ),
  );
}
