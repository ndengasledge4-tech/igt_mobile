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
          /*
          =======================================================
          Flux de connexion (sera implémenté avec l'API)
          =======================================================

          1. Vérifier le matricule/email et le mot de passe.

          2. Si le compte n'existe pas :
             -> RouteNames.register

          3. Si le compte existe mais n'est pas encore activé :
             -> RouteNames.activation

          4. Si le compte est en attente de validation :
             -> RouteNames.waitingValidation

          5. Si le compte est valide :
             -> RouteNames.navigation
          */

          // Interface uniquement
          Navigator.pushReplacementNamed(
            context,
            RouteNames.navigation,
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
          "Se connecter",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}