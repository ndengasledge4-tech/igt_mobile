import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/premium_ui.dart';

class ModifierEmailPage extends StatelessWidget {
  const ModifierEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Email de récupération',
        subtitle: 'Sécurisez l’accès à votre compte',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          maxWidth: 720,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "L'adresse e-mail de récupération est utilisée pour sécuriser votre compte et vous aider à le récupérer en cas de besoin.",
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: 32),
              const Text("Email actuel", style: AppTextStyles.label),
              const SizedBox(height: 8),
              Text(
                'ben***@gmail.com',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const Text("Nouvel email", style: AppTextStyles.label),
              const SizedBox(height: 8),
              const AppTextField(
                hintText: "Entrez votre nouvel email",
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 48),
              AppButton(
                text: "Soumettre",
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Email de récupération soumis"),
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
