import 'package:flutter/material.dart';

import '../../../shared/widgets/auth_shell.dart';
import 'widgets/activate_button.dart';
import 'widgets/activation_code_field.dart';
import 'widgets/already_activated_button.dart';
import 'widgets/help_card.dart';
import 'widgets/matricule_field.dart';

class ActivationPage extends StatelessWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthShell(
      eyebrow: 'Première connexion',
      title: 'Activez votre espace',
      description:
          'Utilisez le matricule et le code remis par l’administration pour sécuriser votre accès.',
      icon: Icons.verified_user_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MatriculeField(),
          SizedBox(height: 16),
          ActivationCodeField(),
          SizedBox(height: 22),
          ActivateButton(),
          SizedBox(height: 8),
          AlreadyActivatedButton(),
          SizedBox(height: 18),
          HelpCard(),
        ],
      ),
    );
  }
}
