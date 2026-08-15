import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 34, 28, 38),
      decoration: const BoxDecoration(color: Color(0xFF3F88C5)),
      child: Column(
        children: [
          // =====================================================
          // LOGO IGT
          // =====================================================
          Container(
            width: 92,
            height: 92,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Image.asset(
              'assets/logo/logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.school_rounded,
                  color: Color(0xFF3F88C5),
                  size: 50,
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // =====================================================
          // NOM
          // =====================================================
          const Text(
            'IGT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 6),

          // =====================================================
          // SOUS-TITRE
          // =====================================================
          const Text(
            'Institut de Gestion et de Technologie',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE5F1FB),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          // =====================================================
          // PETIT INDICATEUR
          // =====================================================
          Container(
            width: 36,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
