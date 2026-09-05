import 'package:flutter/material.dart';

import '../../../../../shared/widgets/auth_shell.dart';
import '../../widgets/reinitialisation/password_reset_form.dart';
import '../../widgets/reinitialisation/password_reset_success.dart';
import '../login/connexion_page.dart';

class ReinitialisationPage extends StatefulWidget {
  const ReinitialisationPage({super.key});

  @override
  State<ReinitialisationPage> createState() => _ReinitialisationPageState();
}

class _ReinitialisationPageState extends State<ReinitialisationPage> {
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      eyebrow: _success ? 'Compte sécurisé' : 'Nouveau mot de passe',
      title: _success ? 'Mot de passe modifié' : 'Sécurisez votre compte',
      description: _success
          ? 'Votre nouveau mot de passe est maintenant actif.'
          : 'Utilisez au moins huit caractères, avec une majuscule, un chiffre et un symbole.',
      icon: _success ? Icons.check_rounded : Icons.lock_reset_rounded,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 240),
        child: _success
            ? PasswordResetSuccess(
                key: const ValueKey('success'),
                onContinue: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const ConnexionPage(),
                  ),
                  (route) => false,
                ),
              )
            : Column(
                key: const ValueKey('form'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const PasswordResetForm(),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    onPressed: () => setState(() => _success = true),
                    child: const Text('Réinitialiser le mot de passe'),
                  ),
                ],
              ),
      ),
    );
  }
}
