import 'package:flutter/material.dart';

import '../../pages/forgot_password/mot_de_passe_oublie_page.dart';
import '../../pages/register/creation_compte_page.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MotDePasseOubliePage(),
                ),
              );
            },
            child: const Text(
              'Mot de passe oublié ?',
              style: TextStyle(
                color: Color(0xFF3F76A5),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              'Pas encore de compte ? ',
              style: TextStyle(
                color: Color(0xFF91A0AE),
                fontSize: 16,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreationComptePage(),
                  ),
                );
              },
              child: const Text(
                'Créer un compte',
                style: TextStyle(
                  color: Color(0xFF3F76A5),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}