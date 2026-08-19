import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';

class ModifierTelephonePage extends StatelessWidget {
  const ModifierTelephonePage({super.key});

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
          "Téléphone de récupération",
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Le numéro de téléphone de récupération est utilisé pour vous aider à accéder à votre compte si vous oubliez votre mot de passe.",
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 32),
            const Text("Numéro de téléphone actuel", style: AppTextStyles.label),
            const SizedBox(height: 8),
            const Text(
              "+242 06 123 45 67",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 32),
            const Text("Nouveau numéro de téléphone", style: AppTextStyles.label),
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
    );
  }
}
