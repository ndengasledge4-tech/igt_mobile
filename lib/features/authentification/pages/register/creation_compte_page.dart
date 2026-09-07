import 'package:flutter/material.dart';

import '../../widgets/register/register_header.dart';
import '../../widgets/register/register_password_form.dart';
import '../../widgets/register/register_personal_form.dart';
import '../../widgets/register/register_progress.dart';
import '../login/connexion_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/controllers/auth_controller.dart';

class CreationComptePage extends StatefulWidget {
  const CreationComptePage({super.key});

  @override
  State<CreationComptePage> createState() => _CreationComptePageState();
}

class _CreationComptePageState extends State<CreationComptePage> {
  int _currentStep = 1;

  final AuthController _authController = AuthController();

  final TextEditingController _passwordController =
  TextEditingController();

  final TextEditingController _confirmationController =
  TextEditingController();

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _matriculeController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _nextStep() async {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      return;
    }

    if (_passwordController.text != _confirmationController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Les mots de passe ne correspondent pas.'),
        ),
      );
      return;
    }

    try {
      await _authController.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        matricule: _matriculeController.text.trim(),
        nom: _lastNameController.text.trim(),
        prenom: _firstNameController.text.trim(),
        telephone: _phoneController.text.trim(),
      );

      if (!mounted) return;

      _showSuccess();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ??
                'Une erreur est survenue lors de la création du compte.',
          ),
        ),
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _showSuccess() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F8EF),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF36A269),
                  size: 42,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Compte créé',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF26384D),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Votre demande de création de compte '
                'a été enregistrée.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF8A98A8),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const ConnexionPage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4388C5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    'Retour à la connexion',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
                child: Column(
                  children: [
                    const RegisterHeader(),

                    const SizedBox(height: 28),

                    RegisterProgress(currentStep: _currentStep),

                    const SizedBox(height: 30),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _currentStep == 1
                          ? RegisterPersonalForm(
                        key: const ValueKey('personal'),
                        lastNameController: _lastNameController,
                        firstNameController: _firstNameController,
                        matriculeController: _matriculeController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                      )
                          : RegisterPasswordForm(
                        key: const ValueKey('password'),
                        passwordController: _passwordController,
                        confirmationController: _confirmationController,
                      )
                    ),

                    const SizedBox(height: 30),

                    _buildNavigationButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE6EAF0))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _previousStep,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF526477),
            ),
          ),

          const SizedBox(width: 4),

          const Text(
            'Créer un compte',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          Text(
            '$_currentStep/2',
            style: const TextStyle(
              color: Color(0xFF4388C5),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (_currentStep > 1) ...[
          Expanded(
            child: SizedBox(
              height: 56,
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF526477),
                  side: const BorderSide(color: Color(0xFFD5DDE5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Retour',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],

        Expanded(
          flex: 2,
          child: SizedBox(
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
              child: Text(
                _currentStep == 1 ? 'Continuer' : 'Créer mon compte',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
