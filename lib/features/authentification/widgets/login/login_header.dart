import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 28, 32, 30),
      decoration: const BoxDecoration(
        color: Color(0xFF3F88C5),
        borderRadius: BorderRadius.vertical(),
      ),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: 48,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'IGT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Institut de Gestion et de Technologie',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFDCEBFA), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
