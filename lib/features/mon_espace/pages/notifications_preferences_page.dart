import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class NotificationsPreferencesPage extends StatefulWidget {
  const NotificationsPreferencesPage({super.key});

  @override
  State<NotificationsPreferencesPage> createState() =>
      _NotificationsPreferencesPageState();
}

class _NotificationsPreferencesPageState
    extends State<NotificationsPreferencesPage> {
  final Map<String, bool> _preferences = {
    'générales': true,
    'actualités': true,
    'événements': true,
    'académiques': true,
    'messages': true,
    'administratives': true,
    'promotions': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Préférences de notifications',
        subtitle: 'Choisissez les alertes utiles',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gérez les types de notifications que vous souhaitez recevoir dans l'application",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                "Types de notifications",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              _buildGroupedPreferencesCard(),
              const SizedBox(height: 24),

              _buildInfoCard(
                icon: Icons.info_outline,
                text: "Information",
                subtext:
                    "Vous recevrez toujours les notifications importantes même si certaines catégories sont désactivées.",
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupedPreferencesCard() {
    return AppSurface(
      padding: EdgeInsets.zero,
      radius: 12,
      child: Column(
        children: [
          _buildPreferenceItem(
            key: 'générales',
            icon: Icons.notifications_none_outlined,
            title: "Notifications générales",
            subtitle: "Informations importantes sur votre compte",
          ),
          const Divider(height: 1, indent: 60),
          _buildPreferenceItem(
            key: 'actualités',
            icon: Icons.campaign_outlined,
            title: "Actualités",
            subtitle: "Nouvelles et annonces de l'IGT",
          ),
          const Divider(height: 1, indent: 60),
          _buildPreferenceItem(
            key: 'événements',
            icon: Icons.calendar_today_outlined,
            title: "Événements",
            subtitle: "Rappels et informations sur les événements",
          ),
          const Divider(height: 1, indent: 60),
          _buildPreferenceItem(
            key: 'académiques',
            icon: Icons.school_outlined,
            title: "Informations académiques",
            subtitle: "Résultats, emplois du temps, etc.",
          ),
          const Divider(height: 1, indent: 60),
          _buildPreferenceItem(
            key: 'messages',
            icon: Icons.mail_outline,
            title: "Messages",
            subtitle: "Messages de l'administration",
          ),
          const Divider(height: 1, indent: 60),
          _buildPreferenceItem(
            key: 'administratives',
            icon: Icons.admin_panel_settings_outlined,
            title: "Notifications administratives",
            subtitle: "Notifications liées à la gestion",
          ),
          const Divider(height: 1, indent: 60),
          _buildPreferenceItem(
            key: 'promotions',
            icon: Icons.local_offer_outlined,
            title: "Promotions et offres",
            subtitle: "Offres spéciales et promotions",
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem({
    required String key,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return SwitchListTile(
      value: _preferences[key] ?? false,
      onChanged: (bool value) {
        setState(() {
          _preferences[key] = value;
        });
      },
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.semanticColors.textSecondary,
        ),
      ),
      activeThumbColor: AppColors.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String text,
    required String subtext,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  subtext,
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
}
