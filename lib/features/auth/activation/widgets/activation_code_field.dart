import 'package:flutter/material.dart';

class ActivationCodeField extends StatelessWidget {
  const ActivationCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Code d'activation",
        hintText: "Entrez votre code",
        prefixIcon: const Icon(Icons.verified_user_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}