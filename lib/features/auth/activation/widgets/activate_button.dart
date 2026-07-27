import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';

class ActivateButton extends StatelessWidget {
  const ActivateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          // TODO : Vérifier le matricule et le code d'activation

          Navigator.pushReplacementNamed(
            context,
              RouteNames.createPassword,
          );
        },
        child: const Text(
          "Activer mon compte",
        ),
      ),
    );
  }
}