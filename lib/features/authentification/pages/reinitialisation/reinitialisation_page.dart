import 'package:flutter/material.dart';

import '../../widgets/reinitialisation/password_reset_form.dart';
import '../../widgets/reinitialisation/password_reset_success.dart';
import '../login/connexion_page.dart';

class ReinitialisationPage extends StatefulWidget {
  const ReinitialisationPage({super.key});

  @override
  State<ReinitialisationPage> createState() =>
      _ReinitialisationPageState();
}

class _ReinitialisationPageState
    extends State<ReinitialisationPage> {
  bool _success = false;

  void _resetPassword() {
    setState(() {
      _success = true;
    });
  }

  void _goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const ConnexionPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  30,
                  24,
                  30,
                ),
                child: _success
                    ? PasswordResetSuccess(
                  onContinue: _goToLogin,
                )
                    : _buildResetForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE6EAF0),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF4388C5),
              ),
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            'Nouveau mot de passe',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FB),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.lock_reset_rounded,
              size: 46,
              color: Color(0xFF4388C5),
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Créer un nouveau mot de passe',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Choisissez un nouveau mot de passe pour sécuriser '
              'votre compte étudiant.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF8A98A8),
            fontSize: 16,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 35),

        const PasswordResetForm(),

        const SizedBox(height: 30),

        SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _resetPassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4388C5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Réinitialiser le mot de passe',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}