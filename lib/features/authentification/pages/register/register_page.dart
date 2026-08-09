import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

import '../../widgets/register/register_logo.dart';
import '../../widgets/register/register_title.dart';
import '../../widgets/register/register_step_indicator.dart';
import '../../widgets/register/personal_information_form.dart';
import '../../widgets/register/academic_information_form.dart';
import '../../widgets/register/security_information_form.dart';
import '../../widgets/register/register_navigation_buttons.dart';




class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _currentStep = 1;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submit() {
    // TODO
    // Navigator.pushNamed(
    //   context,
    //   RouteNames.waitingValidation,
    // );
  }

  Widget _currentForm() {
    switch (_currentStep) {
      case 1:
        return const PersonalInformationForm();

      case 2:
        return const AcademicInformationForm();

      case 3:
        return const SecurityInformationForm();

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: [

              const SizedBox(height: 20),

              const RegisterLogo(),

              const SizedBox(height: 24),

              const RegisterTitle(),

              const SizedBox(height: 30),

              RegisterStepIndicator(
                currentStep: _currentStep,
              ),

              const SizedBox(height: 30),

              AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 400,
                ),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (
                    child,
                    animation,
                    ) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(
                        0.15,
                        0,
                      ),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  key: ValueKey(_currentStep),
                  child: _currentForm(),
                ),
              ),

              const SizedBox(height: 35),

              RegisterNavigationButtons(
                currentStep: _currentStep,
                onNext: _nextStep,
                onPrevious: _previousStep,
                onSubmit: _submit,
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}