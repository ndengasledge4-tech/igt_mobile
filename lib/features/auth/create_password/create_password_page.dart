import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import 'widgets/confirm_password_field.dart';
import 'widgets/create_password_button.dart';
import 'widgets/create_password_description.dart';
import 'widgets/create_password_logo.dart';
import 'widgets/create_password_title.dart';
import 'widgets/new_password_field.dart';
import 'widgets/password_requirements.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

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

              CreatePasswordLogo(),

              SizedBox(height: 28),

              CreatePasswordTitle(),

              SizedBox(height: 18),

              CreatePasswordDescription(),

              SizedBox(height: 30),

              NewPasswordField(),

              SizedBox(height: 18),

              ConfirmPasswordField(),

              SizedBox(height: 20),

              PasswordRequirements(),

              SizedBox(height: 30),

              CreatePasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}
