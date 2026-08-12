import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/widgets/app_logo.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("À propos"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const AppLogo(size: 100),
            const SizedBox(height: 16),
            const Text(
              "IGT Mobile Student",
              style: AppTextStyles.headline2,
            ),
            const Text(
              "Version 1.0.0",
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 40),
            Text(
              "L'application IGT Mobile Student est conçue pour faciliter la vie académique des étudiants de l'IGT. Elle permet d'accéder aux cours, notes, emplois du temps et de suivre sa situation financière en temps réel.",
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(color: AppColors.secondaryText),
            ),
            const SizedBox(height: 40),
            _buildInfoCard(),
            const SizedBox(height: 40),
            const Text(
              "© 2024 IGT - Tous droits réservés",
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildLinkItem(Icons.web, "Site web", "https://igt.sn"),
          const Divider(color: AppColors.divider),
          _buildLinkItem(Icons.policy_outlined, "Politique de confidentialité", ""),
          const Divider(color: AppColors.divider),
          _buildLinkItem(Icons.description_outlined, "Conditions générales d'utilisation", ""),
        ],
      ),
    );
  }

  Widget _buildLinkItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: AppTextStyles.caption) : null,
      trailing: const Icon(Icons.open_in_new, size: 18, color: AppColors.hint),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        // Logique d'ouverture de lien
      },
    );
  }
}
