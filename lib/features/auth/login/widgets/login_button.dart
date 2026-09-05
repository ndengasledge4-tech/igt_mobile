import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/colors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // TODO :
          // 1. Vérifier les identifiants auprès de l'API
          // 2. Si le compte n'est pas activé :
          // Navigator.pushReplacementNamed(context, RouteNames.activation);
          //
          // 3. Si le compte est activé :
          Navigator.pushReplacementNamed(context, RouteNames.navigation);
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
          "Se connecter",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
