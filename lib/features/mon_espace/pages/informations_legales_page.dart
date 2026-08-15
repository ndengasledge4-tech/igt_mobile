import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "Informations légales",
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Consultez les informations légales et réglementaires relatives à l'application.",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildGroupedLegalCard(context),
            const SizedBox(height: 32),

            const Text(
              "À propos de l'application",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),

            _buildAboutCard(),
            
            const SizedBox(height: 32),
            const Center(
              child: Text(
                "© 2025 IGT. Tous droits réservés.",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.hint,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupedLegalCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          _buildLegalItem(
            context: context,
            icon: Icons.assignment_outlined,
            title: "Conditions d'utilisation",
            subtitle: "Consultez les conditions générales d'utilisation de l'application.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.verified_user_outlined,
            title: "Politique de confidentialité",
            subtitle: "Découvrez comment nous collectons, utilisons et protégeons vos données personnelles.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.gavel_outlined,
            title: "Mentions légales",
            subtitle: "Informations légales sur l'éditeur et l'hébergeur de l'application.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.description_outlined,
            title: "Politique de cookies",
            subtitle: "En savoir plus sur l'utilisation des cookies et vos choix associés.",
          ),
          const Divider(height: 1, indent: 60),
          _buildLegalItem(
            context: context,
            icon: Icons.copyright_outlined,
            title: "Droits d'auteur",
            subtitle: "Informations sur les droits d'auteur et la propriété intellectuelle.",
          ),
          const Divider(height: 1, indent: 56),
          _buildLegalItem(
            context: context,
            icon: Icons.help_outline,
            title: "Foire aux questions légales",
            subtitle: "Réponses aux questions fréquentes sur les aspects légaux de l'application.",
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
          color: AppColors.softBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.secondaryText,
          ),
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.hint),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildAboutCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
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
              children: const [
                Text(
                  "IGT - Institut de Gestion et des Techniques",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Dernière mise à jour : 15 mai 2025",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.hint,
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
