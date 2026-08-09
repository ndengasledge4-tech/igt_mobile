import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';

class StudentIdField extends StatelessWidget {
  const StudentIdField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Numéro étudiant",
          style: AppTextStyles.title,
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 48,
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "ex: IGT2024-0123",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}