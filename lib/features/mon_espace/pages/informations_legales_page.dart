import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class InformationsLegalesPage extends StatelessWidget {
  const InformationsLegalesPage({super.key});

  void _showNotAvailableMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Non disponible"),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Informations légales',
        subtitle: 'Confidentialité et conditions',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Consultez les informations légales et réglementaires relatives à l'application.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              _buildGroupedLegalCard(context),
              const SizedBox(height: 32),

              Text(
                "À propos de l'application",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              _buildAboutCard(context),

              const SizedBox(height: 32),
              Center(
                child: Text(
                  "© 2025 IGT. Tous droits réservés.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textDisabled,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupedLegalCard(BuildContext context) {
    return AppSurface(
      padding: EdgeInsets.zero,
      radius: 12,
      child: Column(
        children: [
          _buildLegalItem(
            context: context,
            icon: Icons.assignment_outlined,
            title: "Conditions d'utilisation",
            subtitle:
                "Consultez les conditions générales d'utilisation de l'application.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.verified_user_outlined,
            title: "Politique de confidentialité",
            subtitle:
                "Découvrez comment nous collectons, utilisons et protégeons vos données personnelles.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.gavel_outlined,
            title: "Mentions légales",
            subtitle:
                "Informations légales sur l'éditeur et l'hébergeur de l'application.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.description_outlined,
            title: "Politique de cookies",
            subtitle:
                "En savoir plus sur l'utilisation des cookies et vos choix associés.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.copyright_outlined,
            title: "Droits d'auteur",
            subtitle:
                "Informations sur les droits d'auteur et la propriété intellectuelle.",
          ),
          const Divider(height: 1, indent: 56),
          _buildLegalItem(
            context: context,
            icon: Icons.help_outline,
            title: "Foire aux questions légales",
            subtitle:
                "Réponses aux questions fréquentes sur les aspects légaux de l'application.",
          ),
        ],
      ),
    );
  }

  Widget _buildLegalItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      onTap: () => _showNotAvailableMessage(context),
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
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
          ),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 18,
        color: context.semanticColors.textDisabled,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildAboutCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IGT - Institut de Gestion et des Techniques",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  "Version 1.0.0",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Dernière mise à jour : 15 mai 2025",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: context.semanticColors.textDisabled,
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
