import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'À propos',
        subtitle: 'IGT Mobile Student',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          maxWidth: 720,
          child: Column(
            children: [
              const AppLogo(size: 100),
              const SizedBox(height: 16),
              const Text("IGT Mobile Student", style: AppTextStyles.headline2),
              const Text("Version 1.0.0", style: AppTextStyles.caption),
              const SizedBox(height: 40),
              Text(
                "L'application IGT Mobile Student est conçue pour faciliter la vie académique des étudiants de l'IGT. Elle permet d'accéder aux cours, notes, emplois du temps et de suivre sa situation financière en temps réel.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              _buildInfoCard(context),
              const SizedBox(height: 40),
              const Text(
                "© 2024 IGT - Tous droits réservés",
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildLinkItem(
            context,
            Icons.web,
            'Site web',
            'https://igt.sn',
            external: true,
            onTap: () => _openExternal(context, Uri.parse('https://igt.sn')),
          ),
          Divider(color: context.semanticColors.border),
          _buildLinkItem(
            context,
            Icons.policy_outlined,
            "Politique de confidentialité",
            "",
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.informationsLegales),
          ),
          Divider(color: context.semanticColors.border),
          _buildLinkItem(
            context,
            Icons.description_outlined,
            "Conditions générales d'utilisation",
            "",
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.informationsLegales),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
    bool external = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: AppTextStyles.caption)
          : null,
      trailing: Icon(
        external ? Icons.open_in_new : Icons.chevron_right_rounded,
        size: 18,
        color: context.semanticColors.textDisabled,
      ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }

  Future<void> _openExternal(BuildContext context, Uri uri) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (opened || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Impossible d’ouvrir le site pour le moment.'),
      ),
    );
  }
}
