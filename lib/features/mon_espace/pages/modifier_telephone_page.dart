import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/premium_ui.dart';

class ModifierTelephonePage extends StatelessWidget {
  const ModifierTelephonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Téléphone de récupération',
        subtitle: 'Gardez un accès de secours',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          maxWidth: 720,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Le numéro de téléphone de récupération est utilisé pour vous aider à accéder à votre compte si vous oubliez votre mot de passe.",
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: 32),
              const Text(
                "Numéro de téléphone actuel",
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 8),
              Text(
                '+242 06 123 45 67',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Nouveau numéro de téléphone",
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 8),
              const AppTextField(
                hintText: "Entrez le nouveau numéro",
                prefixIcon: Icons.phone_android_outlined,
              ),
              const SizedBox(height: 48),
              AppButton(
                text: "Soumettre",
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Numéro de récupération soumis"),
                      backgroundColor: AppColors.success,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
