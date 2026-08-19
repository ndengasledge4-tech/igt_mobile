import 'package:flutter/material.dart';

class SplashLoader extends StatelessWidget {
  const SplashLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
        ),

        const SizedBox(height: 18),

        Text(
          "Chargement...",
          style: TextStyle(
            color: Colors.white.withValues(alpha: .85),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),
        ),
      ],
    );
  }
}
