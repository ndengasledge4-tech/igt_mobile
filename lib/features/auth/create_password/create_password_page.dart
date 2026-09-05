import 'package:flutter/material.dart';

import '../../../shared/widgets/auth_shell.dart';
import 'widgets/confirm_password_field.dart';
import 'widgets/create_password_button.dart';
import 'widgets/new_password_field.dart';
import 'widgets/password_requirements.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthShell(
      eyebrow: 'Sécurité du compte',
      title: 'Créez votre mot de passe',
      description:
          'Choisissez un mot de passe robuste et unique pour protéger votre espace étudiant.',
      icon: Icons.lock_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NewPasswordField(),
          SizedBox(height: 16),
          ConfirmPasswordField(),
          SizedBox(height: 18),
          PasswordRequirements(),
          SizedBox(height: 22),
          CreatePasswordButton(),
        ],
      ),
    );
  }
}
