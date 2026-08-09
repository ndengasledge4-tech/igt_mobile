import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_form.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();

  final _identifiantController = TextEditingController();
  final _motDePasseController = TextEditingController();

  @override
  void dispose() {
    _identifiantController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  void _seConnecter() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      RouteNames.navigation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                const AuthHeader(
                  title: 'Bienvenue',
                  subtitle:
                  'Connectez-vous à votre espace étudiant',
                ),

                const SizedBox(height: 36),

                LoginForm(
                  identifiantController: _identifiantController,
                  motDePasseController: _motDePasseController,
                ),

                const SizedBox(height: 14),

                AuthButton(
                  label: 'Se connecter',
                  onPressed: _seConnecter,
                ),

                const SizedBox(height: 12),

                const LoginFooter(),

                const SizedBox(height: 20),

                const Text(
                  'IGT Mobile Student',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}