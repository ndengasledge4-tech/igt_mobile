import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';
import 'forgot_password.dart';
import 'login_button.dart';
import 'password_field.dart';
import 'student_id_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Bienvenue",
          style: AppTextStyles.headline2,
        ),

        SizedBox(height: 6),

        Text(
          "Connectez-vous à votre espace étudiant",
          style: AppTextStyles.bodySmall,
        ),

        SizedBox(height: 24),

        StudentIdField(),

        SizedBox(height: 18),

        PasswordField(),

        SizedBox(height: 6),

        ForgotPassword(),

        SizedBox(height: 24),

        LoginButton(),
      ],
    );
  }
}