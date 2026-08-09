import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.identifiantController,
    required this.motDePasseController,
  });

  final TextEditingController identifiantController;
  final TextEditingController motDePasseController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  InputDecoration _decoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Identifiant',
          style: AppTextStyles.title,
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: widget.identifiantController,
          decoration: _decoration(
            hint: 'Matricule ou adresse e-mail',
            icon: Icons.person_outline_rounded,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Veuillez saisir votre identifiant';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        Text(
          'Mot de passe',
          style: AppTextStyles.title,
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: widget.motDePasseController,
          obscureText: _obscurePassword,
          decoration: _decoration(
            hint: 'Votre mot de passe',
            icon: Icons.lock_outline_rounded,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez saisir votre mot de passe';
            }

            return null;
          },
        ),
      ],
    );
  }
}