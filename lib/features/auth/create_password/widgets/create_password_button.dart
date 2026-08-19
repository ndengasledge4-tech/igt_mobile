import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import 'password_success_card.dart';

class CreatePasswordButton extends StatelessWidget {
  const CreatePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return const Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(24),
                child: PasswordSuccessCard(),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Créer mon mot de passe",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
