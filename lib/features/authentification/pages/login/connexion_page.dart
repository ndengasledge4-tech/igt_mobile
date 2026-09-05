import 'package:flutter/material.dart';

import '../../../../../app/theme/colors.dart';
import '../../../../../app/theme/semantic_colors.dart';
import '../../../../../shared/widgets/premium_ui.dart';
import '../../widgets/login/login_button.dart';
import '../../widgets/login/login_footer.dart';
import '../../widgets/login/login_form.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width < 360 ? 16.0 : 24.0;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(horizontal, 24, horizontal, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 470),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _LoginIdentity(),
                  const SizedBox(height: 28),
                  AppSurface(
                    radius: 24,
                    padding: EdgeInsets.all(width < 360 ? 18 : 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Heureux de vous revoir',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontSize: 24, letterSpacing: -0.4),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Connectez-vous pour retrouver votre espace académique.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: context.semanticColors.textSecondary,
                              ),
                        ),
                        const SizedBox(height: 25),
                        const LoginForm(),
                        const SizedBox(height: 4),
                        const LoginButton(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginIdentity extends StatelessWidget {
  const _LoginIdentity();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 62,
          height: 62,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: context.semanticColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryStrong.withValues(alpha: 0.1),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset('assets/logo/Logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IGT Mobile',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 3),
              Text(
                'L’excellence académique, au quotidien',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
