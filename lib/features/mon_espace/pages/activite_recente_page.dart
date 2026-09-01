import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class ActiviteRecentePage extends StatelessWidget {
  const ActiviteRecentePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Activité récente',
        subtitle: 'Connexions et appareils',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Consultez les appareils sur lesquels vous êtes connecté et l'historique de vos connexions.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionHeader(context, "APPAREIL ACTUEL"),
              _buildDeviceCard(
                context,
                deviceName: "iPhone 15 Pro (Cet appareil)",
                location: "Dakar, Sénégal",
                lastActive: "En ligne maintenant",
                icon: Icons.smartphone,
                isCurrent: true,
              ),
              const SizedBox(height: 24),

              _buildSectionHeader(context, "APPAREILS CONNECTÉS"),
              _buildGroupedCard(context, [
                _buildDeviceItem(
                  context,
                  deviceName: "MacBook Pro 16\"",
                  location: "Dakar, Sénégal",
                  lastActive: "Connecté le 12 Fév 2024",
                  icon: Icons.laptop,
                ),
                _buildDeviceItem(
                  context,
                  deviceName: "Samsung Galaxy S23",
                  location: "Saint-Louis, Sénégal",
                  lastActive: "Connecté le 05 Fév 2024",
                  icon: Icons.smartphone,
                ),
              ]),
              const SizedBox(height: 24),

              _buildSectionHeader(context, "CONNEXIONS RÉCENTES"),
              _buildGroupedCard(context, [
                _buildActivityItem(
                  context,
                  title: "Connexion réussie",
                  subtitle: "Chrome sur Windows • Dakar",
                  date: "Aujourd'hui à 09:41",
                ),
                _buildActivityItem(
                  context,
                  title: "Connexion réussie",
                  subtitle: "App Mobile • iPhone 15 Pro",
                  date: "Hier à 18:20",
                ),
                _buildActivityItem(
                  context,
                  title: "Nouvel appareil détecté",
                  subtitle: "MacBook Pro • Dakar",
                  date: "12 Fév 2024 à 14:05",
                  isWarning: true,
                ),
              ]),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: context.semanticColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDeviceCard(
    BuildContext context, {
    required String deviceName,
    required String location,
    required String lastActive,
    required IconData icon,
    bool isCurrent = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent
              ? AppColors.primary.withValues(alpha: 0.3)
              : context.semanticColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$location • $lastActive",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isCurrent)
            const Icon(Icons.check_circle, color: AppColors.success, size: 20),
        ],
      ),
    );
  }

  Widget _buildGroupedCard(BuildContext context, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          if (index == items.length - 1) return items[index];
          return Column(
            children: [items[index], const Divider(height: 1, indent: 60)],
          );
        }),
      ),
    );
  }

  Widget _buildDeviceItem(
    BuildContext context, {
    required String deviceName,
    required String location,
    required String lastActive,
    required IconData icon,
  }) {
    return ListTile(
      leading: Container(
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
      title: Text(
        deviceName,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "$location • $lastActive",
        style: const TextStyle(fontSize: 11),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 18,
        color: context.semanticColors.textDisabled,
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String date,
    bool isWarning = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isWarning
              ? Theme.of(context).colorScheme.errorContainer
              : Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isWarning ? Icons.warning_amber_rounded : Icons.login_rounded,
          color: isWarning
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isWarning
              ? Theme.of(context).colorScheme.error
              : context.semanticColors.textPrimary,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: const TextStyle(fontSize: 11)),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: context.semanticColors.textDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
