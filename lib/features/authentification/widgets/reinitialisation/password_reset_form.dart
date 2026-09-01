import 'package:flutter/material.dart';

import '../../../../app/theme/semantic_colors.dart';

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({super.key});

  @override
  State<PasswordResetForm> createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nouveau mot de passe',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Votre nouveau mot de passe',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
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
        ),

        const SizedBox(height: 22),

        Text(
          'Confirmer le mot de passe',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: _obscureConfirmation,
          decoration: InputDecoration(
            hintText: 'Confirmez votre mot de passe',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmation = !_obscureConfirmation;
                });
              },
              icon: Icon(
                _obscureConfirmation
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Votre mot de passe doit contenir :',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              const _PasswordRule(text: 'Au moins 8 caractères'),
              const _PasswordRule(text: 'Une lettre majuscule'),
              const _PasswordRule(text: 'Une lettre minuscule'),
              const _PasswordRule(text: 'Un chiffre'),
            ],
          ),
        ),
      ],
    );
  }
}

class _PasswordRule extends StatelessWidget {
  final String text;

  const _PasswordRule({required this.text});

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
          const SizedBox(width: 9),
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
