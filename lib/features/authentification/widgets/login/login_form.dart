import 'package:flutter/material.dart';

import '../../pages/forgot_password/mot_de_passe_oublie_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Identifiant / Email', style: theme.textTheme.labelLarge),

        const SizedBox(height: 10),

        TextField(
          decoration: InputDecoration(
            hintText: 'ex: 2024IG001 ou email@igt.edu',
            prefixIcon: const Icon(Icons.person_rounded),
          ),
        ),

        const SizedBox(height: 22),

        Text('Mot de passe', style: theme.textTheme.labelLarge),

        const SizedBox(height: 10),

        TextField(
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Votre mot de passe',
            prefixIcon: const Icon(Icons.lock_rounded),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MotDePasseOubliePage()),
              );
            },
            child: Text(
              'Mot de passe oublié ?',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
