import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import 'widgets/activation_logo.dart';
import 'widgets/activation_title.dart';
import 'widgets/activation_description.dart';
import 'widgets/matricule_field.dart';
import 'widgets/activation_code_field.dart';
import 'widgets/activate_button.dart';
import 'widgets/already_activated_button.dart';
import 'widgets/help_card.dart';

class ActivationPage extends StatelessWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: const Column(
            children: [
              SizedBox(height: 20),

              ActivationLogo(),

              SizedBox(height: 30),

              ActivationTitle(),

              SizedBox(height: 18),

              ActivationDescription(),

              SizedBox(height: 30),

              MatriculeField(),

              SizedBox(height: 18),

              ActivationCodeField(),

              SizedBox(height: 30),

              ActivateButton(),

              SizedBox(height: 16),

              AlreadyActivatedButton(),

              SizedBox(height: 30),

              HelpCard(),
            ],
          ),
        ),
      ),
    );
  }
}
