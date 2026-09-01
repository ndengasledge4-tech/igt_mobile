import 'package:flutter/material.dart';

import '../../../../../app/routes/route_names.dart';
import '../../../../../app/theme/semantic_colors.dart';
import '../../../../../shared/widgets/auth_shell.dart';

class WaitingValidationPage extends StatelessWidget {
  const WaitingValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    void returnToLogin() => Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.connexion,
      (route) => false,
    );

    return AuthShell(
      eyebrow: 'Validation du compte',
      title: 'Compte en attente de validation',
      description:
          'Votre demande de création de compte a bien été enregistrée.',
      icon: Icons.hourglass_top_rounded,
      onBack: returnToLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: context.semanticColors.warning.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: context.semanticColors.warning.withValues(alpha: 0.28),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: context.semanticColors.warning,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Statut : en attente de validation',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: context.semanticColors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Que se passe-t-il maintenant ?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          const _InformationRow(
            icon: Icons.fact_check_outlined,
            text: 'Votre dossier est en cours de vérification.',
          ),
          const SizedBox(height: 13),
          const _InformationRow(
            icon: Icons.verified_user_outlined,
            text: 'L’administration vérifiera vos informations.',
          ),
          const SizedBox(height: 13),
          const _InformationRow(
            icon: Icons.notifications_none_rounded,
            text: 'Vous serez informé lorsque votre compte sera validé.',
          ),
          const SizedBox(height: 26),
          OutlinedButton.icon(
            onPressed: returnToLogin,
            icon: const Icon(Icons.login_rounded),
            label: const Text('Retour à la connexion'),
          ),
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InformationRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.semanticColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
