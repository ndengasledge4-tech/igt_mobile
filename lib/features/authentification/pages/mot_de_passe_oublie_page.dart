import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';

class MotDePasseOubliePage extends StatefulWidget {
  const MotDePasseOubliePage({super.key});

  @override
  State<MotDePasseOubliePage> createState() =>
      _MotDePasseOubliePageState();
}

class _MotDePasseOubliePageState
    extends State<MotDePasseOubliePage> {
  final _formKey = GlobalKey<FormState>();
  final _identifiantController = TextEditingController();

  @override
  void dispose() {
    _identifiantController.dispose();
    super.dispose();
  }

  void _continuer() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Navigation temporaire : interface uniquement.
    Navigator.pushNamed(
      context,
      '/reinitialisation',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const AuthLogo(),

                const SizedBox(height: 28),

                Text(
                  'Mot de passe oublié ?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headline2,
                ),

                const SizedBox(height: 10),

                Text(
                  'Saisissez votre identifiant pour continuer la procédure de récupération de votre compte.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 34),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Identifiant',
                    style: AppTextStyles.title.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _identifiantController,
                  decoration: InputDecoration(
                    hintText: 'Matricule ou adresse e-mail',
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                    ),
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
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir votre identifiant';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                AuthButton(
                  label: 'Continuer',
                  onPressed: _continuer,
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Retour à la connexion',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}