import 'package:flutter/material.dart';

import '../../pages/register/creation_compte_page.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              'Pas encore de compte ? ',
              style: TextStyle(color: Color(0xFF91A0AE), fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreationComptePage()),
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
