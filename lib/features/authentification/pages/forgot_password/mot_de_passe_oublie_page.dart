import 'package:flutter/material.dart';

import '../../../../../app/routes/route_names.dart';
import '../../../../../app/theme/colors.dart';
import '../../../../../app/theme/semantic_colors.dart';
import '../../../../../shared/widgets/auth_shell.dart';

class MotDePasseOubliePage extends StatefulWidget {
  const MotDePasseOubliePage({super.key});

  @override
  State<MotDePasseOubliePage> createState() => _MotDePasseOubliePageState();
}

class _MotDePasseOubliePageState extends State<MotDePasseOubliePage> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  int _step = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      eyebrow: _step == 0 ? 'Récupération' : 'Vérification',
      title: _step == 0 ? 'Retrouvez votre compte' : 'Vérifiez votre identité',
      description: _step == 0
          ? 'Indiquez votre email institutionnel ou votre matricule. Un code temporaire vous sera envoyé.'
          : 'Saisissez le code à six chiffres envoyé à votre adresse institutionnelle.',
      icon: _step == 0 ? Icons.mark_email_read_rounded : Icons.shield_rounded,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 240),
        child: _step == 0
            ? _EmailStep(
                key: const ValueKey('email'),
                controller: _emailController,
                onContinue: () => setState(() => _step = 1),
              )
            : _CodeStep(
                key: const ValueKey('code'),
                controller: _codeController,
                onContinue: () =>
                    Navigator.pushNamed(context, RouteNames.reinitialisation),
              ),
      ),
    );
  }
}

class _EmailStep extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onContinue;

  const _EmailStep({
    super.key,
    required this.controller,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Email ou matricule',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 9),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '2024IG001 ou nom@igt.edu',
            prefixIcon: Icon(Icons.person_rounded),
          ),
        ),
        const SizedBox(height: 22),
        ElevatedButton(
          onPressed: onContinue,
          child: const Text('Envoyer le code'),
        ),
      ],
    );
  }
}

class _CodeStep extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onContinue;

  const _CodeStep({
    super.key,
    required this.controller,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.secondary,
                size: 20,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Code envoyé. Pensez à vérifier vos courriers indésirables.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Code de vérification',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 9),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(
            hintText: '000000',
            prefixIcon: Icon(Icons.password_rounded),
            counterText: '',
          ),
        ),
        const SizedBox(height: 22),
        ElevatedButton(
          onPressed: onContinue,
          child: const Text('Vérifier le code'),
        ),
      ],
    );
  }
}
