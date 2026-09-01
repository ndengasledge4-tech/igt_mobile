import 'package:flutter/material.dart';

import '../../../../../app/routes/route_names.dart';
import '../../../../../app/theme/semantic_colors.dart';
import '../../../../../shared/widgets/auth_shell.dart';
import '../../widgets/register/register_password_form.dart';
import '../../widgets/register/register_personal_form.dart';
import '../../widgets/register/register_progress.dart';

class CreationComptePage extends StatefulWidget {
  const CreationComptePage({super.key});

  @override
  State<CreationComptePage> createState() => _CreationComptePageState();
}

class _CreationComptePageState extends State<CreationComptePage> {
  int _currentStep = 1;

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      return;
    }
    _showSuccess();
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
      return;
    }
    Navigator.maybePop(context);
  }

  void _showSuccess() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: dialogContext.semanticColors.success,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Compte créé',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Votre demande de création de compte a été enregistrée.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: dialogContext.semanticColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(dialogContext).pushNamedAndRemoveUntil(
                          RouteNames.connexion,
                          (route) => false,
                        ),
                    child: const Text('Retour à la connexion'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      eyebrow: 'Inscription étudiante',
      title: _currentStep == 1
          ? 'Créez votre compte'
          : 'Sécurisez votre compte',
      description: _currentStep == 1
          ? 'Renseignez les informations liées à votre dossier étudiant.'
          : 'Définissez le mot de passe utilisé pour vos prochaines connexions.',
      icon: _currentStep == 1
          ? Icons.person_add_alt_1_rounded
          : Icons.lock_rounded,
      onBack: _previousStep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Étape $_currentStep sur 2',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  _currentStep == 1 ? 'Identité' : 'Sécurité',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RegisterProgress(currentStep: _currentStep),
          const SizedBox(height: 26),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _currentStep == 1
                ? const RegisterPersonalForm(key: ValueKey('personal'))
                : const RegisterPasswordForm(key: ValueKey('password')),
          ),
          const SizedBox(height: 28),
          _NavigationButtons(
            showBack: _currentStep > 1,
            primaryLabel: _currentStep == 1 ? 'Continuer' : 'Créer mon compte',
            onBack: _previousStep,
            onContinue: _nextStep,
          ),
        ],
      ),
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  final bool showBack;
  final String primaryLabel;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const _NavigationButtons({
    required this.showBack,
    required this.primaryLabel,
    required this.onBack,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final primary = ElevatedButton(
      onPressed: onContinue,
      child: Text(primaryLabel),
    );
    if (!showBack) return primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final back = OutlinedButton(
          onPressed: onBack,
          child: const Text('Retour'),
        );
        if (constraints.maxWidth < 340) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [primary, const SizedBox(height: 10), back],
          );
        }
        return Row(
          children: [
            Expanded(child: back),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: primary),
          ],
        );
      },
    );
  }
}
