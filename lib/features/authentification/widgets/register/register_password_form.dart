import 'package:flutter/material.dart';

import '../../../../app/theme/semantic_colors.dart';

class RegisterPasswordForm extends StatefulWidget {
  const RegisterPasswordForm({super.key});

  @override
  State<RegisterPasswordForm> createState() => _RegisterPasswordFormState();
}

class _RegisterPasswordFormState extends State<RegisterPasswordForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sécurisez votre compte',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 7),
        Text(
          'Définissez le mot de passe qui sera utilisé pour vous connecter.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        _passwordField(
          label: 'Mot de passe',
          hint: 'Votre mot de passe',
          obscure: _obscurePassword,
          onVisibilityPressed: () =>
              setState(() => _obscurePassword = !_obscurePassword),
        ),
        const SizedBox(height: 18),
        _passwordField(
          label: 'Confirmer le mot de passe',
          hint: 'Confirmez votre mot de passe',
          obscure: _obscureConfirmation,
          onVisibilityPressed: () =>
              setState(() => _obscureConfirmation = !_obscureConfirmation),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conseils de sécurité',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 9),
              _Rule(text: 'Au moins 8 caractères'),
              _Rule(text: 'Une lettre majuscule'),
              _Rule(text: 'Une lettre minuscule'),
              _Rule(text: 'Un chiffre'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _passwordField({
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback onVisibilityPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 9),
        TextField(
          obscureText: obscure,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              tooltip: obscure
                  ? 'Afficher le mot de passe'
                  : 'Masquer le mot de passe',
              onPressed: onVisibilityPressed,
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Rule extends StatelessWidget {
  final String text;

  const _Rule({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 6,
            color: context.semanticColors.textDisabled,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.semanticColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
