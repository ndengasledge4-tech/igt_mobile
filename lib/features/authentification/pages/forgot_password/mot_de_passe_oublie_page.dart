import 'package:flutter/material.dart';

import '../../widgets/forgot_password/forgot_password_form.dart';
import '../../widgets/forgot_password/forgot_password_header.dart';
import '../../widgets/forgot_password/verification_form.dart';

class MotDePasseOubliePage extends StatefulWidget {
  const MotDePasseOubliePage({super.key});

  @override
  State<MotDePasseOubliePage> createState() => _MotDePasseOubliePageState();
}

class _MotDePasseOubliePageState extends State<MotDePasseOubliePage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();

  int _step = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      if (_step < 1) {
        _step++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            const ForgotPasswordHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
                child: _step == 0
                    ? _buildEmailStep()
                    : _buildVerificationStep(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FC),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.mail_outline_rounded,
              size: 44,
              color: Color(0xFF4388C5),
            ),
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Récupérer mon compte',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Saisissez votre email ou identifiant pour recevoir\n'
          'un lien de réinitialisation.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF8A98A8), fontSize: 16, height: 1.5),
        ),

        const SizedBox(height: 38),

        ForgotPasswordForm(controller: _emailController),

        const SizedBox(height: 30),

        SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4388C5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Envoyer le code',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF4FE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Un code a été envoyé à votre email',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4388C5),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          'Vérification',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Saisissez le code à 6 chiffres reçu par email.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF8A98A8), fontSize: 16),
        ),

        const SizedBox(height: 38),

        VerificationForm(controller: _codeController),

        const SizedBox(height: 30),

        SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // UI uniquement.
              // La navigation vers la réinitialisation
              // sera branchée plus tard.
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4388C5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Vérifier',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
