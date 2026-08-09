import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';

class ReinitialisationPage extends StatefulWidget {
  const ReinitialisationPage({super.key});

  @override
  State<ReinitialisationPage> createState() =>
      _ReinitialisationPageState();
}

class _ReinitialisationPageState
    extends State<ReinitialisationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nouveauMotDePasseController =
  TextEditingController();

  final _confirmationController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  void dispose() {
    _nouveauMotDePasseController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _reinitialiser() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Interface uniquement.
    _afficherSucces();
  }

  void _afficherSucces() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Mot de passe réinitialisé',
          ),
          content: const Text(
            'Votre nouveau mot de passe a été enregistré.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Retour à la connexion',
              ),
            ),
          ],
        );
      },
    );
  }

  InputDecoration _decoration({
    required String hint,
    required Widget suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: const Icon(
        Icons.lock_outline_rounded,
      ),
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
                  'Nouveau mot de passe',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headline2,
                ),

                const SizedBox(height: 10),

                Text(
                  'Définissez un nouveau mot de passe pour sécuriser votre compte étudiant.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 34),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nouveau mot de passe',
                    style: AppTextStyles.title.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _nouveauMotDePasseController,
                  obscureText: _obscurePassword,
                  decoration: _decoration(
                    hint: 'Votre nouveau mot de passe',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword =
                          !_obscurePassword;
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
                      return 'Veuillez saisir un mot de passe';
                    }

                    if (value.length < 8) {
                      return 'Minimum 8 caractères';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirmer le mot de passe',
                    style: AppTextStyles.title.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _confirmationController,
                  obscureText: _obscureConfirmation,
                  decoration: _decoration(
                    hint: 'Confirmez votre mot de passe',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmation =
                          !_obscureConfirmation;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmation
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer votre mot de passe';
                    }

                    if (value !=
                        _nouveauMotDePasseController.text) {
                      return 'Les mots de passe ne correspondent pas';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.softBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.security_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Utilisez au moins 8 caractères avec une combinaison suffisamment sécurisée.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.45,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                AuthButton(
                  label: 'Réinitialiser',
                  onPressed: _reinitialiser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}