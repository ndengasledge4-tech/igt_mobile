import 'package:flutter/material.dart';

class PasswordResetSuccess extends StatelessWidget {
  final VoidCallback? onContinue;

  const PasswordResetSuccess({
    super.key,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F8EF),
            borderRadius: BorderRadius.circular(28),
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 54,
            color: Color(0xFF36A269),
          ),
        ),

        const SizedBox(height: 28),

        const Text(
          'Mot de passe réinitialisé',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Votre mot de passe a été modifié avec succès.\n'
              'Vous pouvez maintenant vous connecter.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF8A98A8),
            fontSize: 16,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 34),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4388C5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Se connecter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}