import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../app/routes/route_names.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class SecuriteComptePage extends StatelessWidget {
  const SecuriteComptePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Sécurité du compte',
        subtitle: 'Accès, récupération et appareils',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gérez et renforcez la sécurité de votre compte pour protéger vos informations.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionHeader(context, "ÉTAT DE SÉCURITÉ"),
              _buildSecurityStatusCard(context),
              const SizedBox(height: 24),

              _buildSectionHeader(context, "SÉCURITÉ DU COMPTE"),
              _buildGroupedSecurityCard(context),
              const SizedBox(height: 24),

              _buildInfoCard(
                context,
                icon: Icons.info_outline,
                text: "Conseil de sécurité",
                subtext:
                    "Ne partagez jamais votre mot de passe et assurez-vous d'utiliser un mot de passe fort et unique.",
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

  Widget _buildSecurityStatusCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Votre compte est sécurisé",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Aucune action requise pour le moment.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.semanticColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 1.0,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              color: AppColors.primary,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "100%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedSecurityCard(BuildContext context) {
    return AppSurface(
      padding: EdgeInsets.zero,
      radius: 12,
      child: Column(
        children: [
          _buildSecurityItem(
            context,
            icon: Icons.lock_outline,
            title: "Modifier le mot de passe",
            subtitle:
                "Changez régulièrement votre mot de passe pour sécuriser votre compte.",
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.modifierMotDePasse),
          ),
          const Divider(height: 1, indent: 56),
          _buildSecurityItem(
            context,
            icon: Icons.fingerprint,
            title: "Face ID ou Empreinte digitale",
            subtitle:
                "Sécurisez l'accès à votre application avec la biométrie.",
            trailingWidget: _buildBadge("Pas disponible", AppColors.error),
          ),
          const Divider(height: 1, indent: 56),
          _buildSecurityItem(
            context,
            icon: Icons.phone_android_outlined,
            title: "Téléphone de récupération",
            subtitle:
                "Le numéro de téléphone utilisé pour récupérer votre compte.",
            trailingText: "+242 06 123 45 67",
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.modifierTelephone),
          ),
          const Divider(height: 1, indent: 56),
          _buildSecurityItem(
            context,
            icon: Icons.email_outlined,
            title: "Email de récupération",
            subtitle: "L'adresse e-mail utilisée pour récupérer votre compte.",
            trailingText: "ben***@gmail.com",
            onTap: () => Navigator.pushNamed(context, RouteNames.modifierEmail),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    String? trailingText,
    Widget? trailingWidget,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
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
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: context.semanticColors.textSecondary,
              ),
            ),
          ?trailingWidget,
          if (onTap != null) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              size: 18,
              color: context.semanticColors.textDisabled,
            ),
          ],
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
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
