import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class SessionsActivesPage extends StatelessWidget {
  const SessionsActivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Sessions actives',
        subtitle: 'Appareils connectés au compte',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gérez les appareils connectés à votre compte et déconnectez-vous si nécessaire.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionHeader(context, "Ma session actuelle"),
              _buildCurrentSessionCard(context),
              const SizedBox(height: 24),

              _buildSectionHeader(context, "Autres sessions actives"),
              _buildOtherSessionItem(
                context,
                device: "Windows • Chrome",
                details: "Windows 11 • Navigateur Chrome",
                time: "Hier à 18:32",
                location: "Brazzaville, Congo",
                ip: "197.210.54.12",
                icon: Icons.laptop,
              ),
              _buildOtherSessionItem(
                context,
                device: "Samsung Galaxy A54",
                details: "Application mobile • Android 14",
                time: "12 mai 2025 à 21:15",
                location: "Pointe-Noire, Congo",
                ip: "41.216.98.76",
                icon: Icons.smartphone,
              ),
              _buildOtherSessionItem(
                context,
                device: "MacBook Air • Safari",
                details: "macOS Sonoma • Navigateur Safari",
                time: "8 mai 2025 à 14:20",
                location: "Paris, France",
                ip: "102.54.12.89",
                icon: Icons.laptop,
              ),

              const SizedBox(height: 16),
              _buildLogoutAllCard(context),

              const SizedBox(height: 24),
              _buildInfoCard(
                context,
                icon: Icons.info_outline,
                text: "Besoin d'aide ?",
                subtext:
                    "Si vous voyez une activité suspecte ou un appareil que vous ne reconnaissez pas, déconnectez-le immédiatement et modifiez votre mot de passe.",
              ),
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
      child: Text(title, style: Theme.of(context).textTheme.titleSmall),
    );
  }

  Widget _buildCurrentSessionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.smartphone,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "iPhone 13",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "Actuelle",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Application mobile • iOS 17.4",
                      style: TextStyle(
                        fontSize: 13,
                        color: context.semanticColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      context,
                      Icons.access_time,
                      "Connexion :",
                      "Aujourd'hui à 09:41",
                    ),
                    _buildDetailRow(
                      context,
                      Icons.location_on_outlined,
                      "Lieu :",
                      "Brazzaville, Congo",
                    ),
                    _buildDetailRow(
                      context,
                      Icons.shield_outlined,
                      "Adresse IP :",
                      "197.210.54.23",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "C'est votre session actuelle. Elle ne peut pas être déconnectée.",
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherSessionItem(
    BuildContext context, {
    required String device,
    required String details,
    required String time,
    required String location,
    required String ip,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      details,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.semanticColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      context,
                      Icons.access_time,
                      "Dernière activité :",
                      time,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.location_on_outlined,
                      "Lieu :",
                      location,
                    ),
                    _buildDetailRow(context, Icons.shield_outlined, "IP :", ip),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _showPrototypeDisconnect(context, device),
              icon: const Icon(Icons.logout, size: 14),
              label: const Text(
                "Déconnecter",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                backgroundColor: AppColors.error.withValues(alpha: 0.05),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: context.semanticColors.textDisabled),
          const SizedBox(width: 4),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label ',
                    style: TextStyle(
                      color: context.semanticColors.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      color: context.semanticColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutAllCard(BuildContext context) {
    return AppSurface(
      color: AppColors.error.withValues(alpha: 0.05),
      onTap: () =>
          _showPrototypeDisconnect(context, 'toutes les autres sessions'),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Déconnecter toutes les autres sessions",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.error,
                  ),
                ),
                Text(
                  "Vous serez déconnecté de tous vos appareils sauf celui que vous utilisez actuellement.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.error, size: 20),
        ],
      ),
    );
  }

  void _showPrototypeDisconnect(BuildContext context, String target) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Déconnexion de $target simulée localement. Le serveur sera connecté lors de l’intégration backend.',
          ),
        ),
      );
  }

  Widget _buildInfoCard(
    BuildContext context, {
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
          Icon(icon, color: AppColors.primary, size: 20),
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
