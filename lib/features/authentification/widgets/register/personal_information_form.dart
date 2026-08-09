import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class PersonalInformationForm extends StatelessWidget {
  const PersonalInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Informations personnelles",
            style: AppTextStyles.title,
          ),

          const SizedBox(height: 6),

          Text(
            "Veuillez renseigner vos informations personnelles.",
            style: AppTextStyles.body.copyWith(
              color: AppColors.secondaryText,
            ),
          ),

          const SizedBox(height: 25),

          _buildField(
            "Nom",
            Icons.person_outline_rounded,
          ),

          const SizedBox(height: 18),

          _buildField(
            "Postnom",
            Icons.person_outline_rounded,
          ),

          const SizedBox(height: 18),

          _buildField(
            "Prénom",
            Icons.person_outline_rounded,
          ),

          const SizedBox(height: 18),

          _buildDropdown(
            "Sexe",
            Icons.people_alt_outlined,
          ),

          const SizedBox(height: 18),

          _buildDateField(),

          const SizedBox(height: 18),

          _buildField(
            "Téléphone",
            Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 18),

          _buildField(
            "Adresse e-mail",
            Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      String hint,
      IconData icon, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String hint,
      IconData icon,
      ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: "Homme",
          child: Text("Homme"),
        ),
        DropdownMenuItem(
          value: "Femme",
          child: Text("Femme"),
        ),
      ],
      onChanged: (_) {},
    );
  }

  Widget _buildDateField() {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: "Date de naissance",
        prefixIcon: const Icon(
          Icons.calendar_today_outlined,
          color: AppColors.primary,
        ),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}