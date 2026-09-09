import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/models/student_account_status.dart';
import '../../../../core/models/student_model.dart';
import '../../widgets/register/register_header.dart';
import '../../widgets/register/register_password_form.dart';
import '../../widgets/register/register_personal_form.dart';
import '../../widgets/register/register_progress.dart';

class CreationComptePage extends StatefulWidget {
  const CreationComptePage({super.key});

  @override
  State<CreationComptePage> createState() => _CreationComptePageState();
}

class _CreationComptePageState extends State<CreationComptePage> {
  final _personalFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _matriculeController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();

  late final AuthController _authController;

  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _matriculeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    _authController.dispose();

    super.dispose();
  }

  Future<void> _nextStep() async {
    FocusScope.of(context).unfocus();
    _authController.clearError();

    if (_currentStep == 1) {
      if (!(_personalFormKey.currentState?.validate() ?? false)) {
        return;
      }

      setState(() {
        _currentStep = 2;
      });

      return;
    }

    if (!(_passwordFormKey.currentState?.validate() ?? false)) {
      return;
    }

    final student = StudentModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      matricule: _matriculeController.text.trim(),
      accountStatus: StudentAccountStatus.pending,
    );

    final success = await _authController.registerStudent(
      student: student,
      password: _passwordController.text,
    );

    if (!mounted || !success) {
      return;
    }

    await _showSuccess();
  }

  void _previousStep() {
    if (_authController.isLoading) {
      return;
    }

    _authController.clearError();

    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _showSuccess() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
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
                'Votre compte et votre profil étudiant ont été enregistrés.',
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
                    Navigator.pop(dialogContext);
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
                    'Continuer',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.waitingValidation,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _authController,
      builder: (context, child) {
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
                                  formKey: _personalFormKey,
                                  lastNameController: _lastNameController,
                                  firstNameController: _firstNameController,
                                  matriculeController: _matriculeController,
                                  emailController: _emailController,
                                  phoneController: _phoneController,
                                )
                              : RegisterPasswordForm(
                                  key: const ValueKey('password'),
                                  formKey: _passwordFormKey,
                                  passwordController: _passwordController,
                                  confirmationController:
                                      _confirmationController,
                                ),
                        ),

                        if (_authController.errorMessage != null) ...[
                          const SizedBox(height: 20),
                          _buildError(_authController.errorMessage!),
                        ],

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
      },
    );
  }

  Widget _buildError(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFECEC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFB42318)),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFFB42318)),
            ),
          ),
        ],
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
            onPressed: _authController.isLoading ? null : _previousStep,
            icon: const Icon(Icons.arrow_back_rounded),
          ),

          const SizedBox(width: 4),

          const Text(
            'Créer un compte',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
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
                onPressed: _authController.isLoading ? null : _previousStep,
                child: const Text('Retour'),
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
              onPressed: _authController.isLoading ? null : _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4388C5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _authController.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
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
