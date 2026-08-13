import 'package:flutter/material.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "INSTITUT DE GESTION\nET DE TECHNOLOGIE",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            height: 1.3,
          ),
        ),

        SizedBox(height: 14),

        Text(
          "Plateforme Étudiante",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 8),

        Text(
          "Apprendre • Réussir • Innover",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white60,
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
