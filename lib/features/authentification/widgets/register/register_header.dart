import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FB),
            borderRadius: BorderRadius.circular(23),
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            color: Color(0xFF4388C5),
            size: 42,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Créer mon compte',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 9),
        const Text(
          'Créez votre compte étudiant pour accéder\n'
              'à votre espace personnel.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF8A98A8),
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}