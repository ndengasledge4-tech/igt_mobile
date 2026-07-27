import 'package:flutter/material.dart';

class MatriculeField extends StatelessWidget {
  const MatriculeField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Matricule",
        hintText: "Ex : 23IGT0015",
        prefixIcon: const Icon(Icons.badge_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}