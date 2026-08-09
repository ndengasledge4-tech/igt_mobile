import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class SecurityInformationForm extends StatelessWidget {
  const SecurityInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Sécurité du compte",
            style: AppTextStyles.title,
          ),

          const SizedBox(height: 6),

          Text(
            "Choisissez un mot de passe sécurisé pour protéger votre compte.",
            style: AppTextStyles.body.copyWith(
              color: AppColors.secondaryText,
            ),
          ),

          const SizedBox(height: 25),

          _buildPasswordField(
            "Mot de passe",
          ),

          const SizedBox(height: 18),

          _buildPasswordField(
            "Confirmer le mot de passe",
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _Requirement(
                  text: "Au moins 8 caractères",
                ),

                SizedBox(height: 10),

                _Requirement(
                  text: "Une lettre majuscule",
                ),

                SizedBox(height: 10),

                _Requirement(
                  text: "Une lettre minuscule",
                ),

                SizedBox(height: 10),

                _Requirement(
                  text: "Un chiffre",
                ),

                SizedBox(height: 10),

                _Requirement(
                  text: "Un caractère spécial",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          CheckboxListTile(
            value: false,
            onChanged: (_) {},
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: Text(
              "J'accepte les conditions d'utilisation et la politique de confidentialité.",
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
      String hint,
      ) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppColors.primary,
        ),
        suffixIcon: const Icon(Icons.visibility_off_outlined),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _Requirement extends StatelessWidget {
  final String text;

  const _Requirement({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        const Icon(
          Icons.check_circle_outline,
          color: AppColors.primary,
          size: 18,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }
}