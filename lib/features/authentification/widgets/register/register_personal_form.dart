import 'package:flutter/material.dart';

import '../../../../app/theme/semantic_colors.dart';

class RegisterPersonalForm extends StatelessWidget {
  const RegisterPersonalForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations personnelles',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 7),
        Text(
          'Renseignez les informations liées à votre dossier étudiant.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        _field(
          context,
          label: 'Nom',
          hint: 'Votre nom',
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 18),
        _field(
          context,
          label: 'Prénom',
          hint: 'Votre prénom',
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 18),
        _field(
          context,
          label: 'Identifiant étudiant',
          hint: 'Ex : 2024IG001',
          icon: Icons.badge_outlined,
        ),
        const SizedBox(height: 18),
        _field(
          context,
          label: 'Email',
          hint: 'email@igt.edu',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 18),
        _field(
          context,
          label: 'Téléphone',
          hint: 'Votre numéro de téléphone',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _field(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 9),
        TextField(
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon)),
        ),
      ],
    );
  }
}
