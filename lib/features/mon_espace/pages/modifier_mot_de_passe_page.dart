import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';

class ModifierMotDePassePage extends StatelessWidget {
  const ModifierMotDePassePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Modifier le mot de passe"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Votre nouveau mot de passe doit être différent des anciens mots de passe.",
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 32),
            const Text("Mot de passe actuel", style: AppTextStyles.label),
            const SizedBox(height: 8),
            const AppTextField(
              hintText: "Entrez votre mot de passe actuel",
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            const Text("Nouveau mot de passe", style: AppTextStyles.label),
            const SizedBox(height: 8),
            const AppTextField(
              hintText: "Entrez le nouveau mot de passe",
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            const Text(
              "Confirmer le nouveau mot de passe",
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 8),
            const AppTextField(
              hintText: "Confirmez le nouveau mot de passe",
              prefixIcon: Icons.lock_reset,
              obscureText: true,
            ),
            const SizedBox(height: 48),
            AppButton(
              text: "Mettre à jour",
              onPressed: () {
                // Logique de mise à jour
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Mot de passe mis à jour avec succès"),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
