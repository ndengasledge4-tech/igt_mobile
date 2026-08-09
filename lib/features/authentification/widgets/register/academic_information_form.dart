import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';

class AcademicInformationForm extends StatelessWidget {
  const AcademicInformationForm({super.key});

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
            "Informations académiques",
            style: AppTextStyles.title,
          ),

          const SizedBox(height: 6),

          Text(
            "Ces informations permettront de retrouver votre dossier académique.",
            style: AppTextStyles.body.copyWith(
              color: AppColors.secondaryText,
            ),
          ),

          const SizedBox(height: 25),

          _buildField(
            "Matricule",
            Icons.badge_outlined,
          ),

          const SizedBox(height: 18),

          _buildDropdown(
            "Campus",
            Icons.location_city_outlined,
            const [
              "Kinshasa",
              "Lubumbashi",
              "Goma",
            ],
          ),

          const SizedBox(height: 18),

          _buildDropdown(
            "Formation",
            Icons.school_outlined,
            const [
              "Génie Informatique",
              "Réseaux & Télécommunications",
              "Gestion",
              "Finance",
            ],
          ),

          const SizedBox(height: 18),

          _buildDropdown(
            "Niveau",
            Icons.stairs_outlined,
            const [
              "L1",
              "L2",
              "L3",
              "M1",
              "M2",
            ],
          ),

          const SizedBox(height: 18),

          _buildField(
            "Classe",
            Icons.groups_outlined,
          ),

          const SizedBox(height: 18),

          _buildDropdown(
            "Année académique",
            Icons.calendar_month_outlined,
            const [
              "2025 - 2026",
              "2026 - 2027",
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      String hint,
      IconData icon,
      ) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
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
      List<String> values,
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
      items: values
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ),
      )
          .toList(),
      onChanged: (_) {},
    );
  }
}