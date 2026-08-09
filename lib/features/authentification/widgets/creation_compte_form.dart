import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class CreationCompteForm extends StatelessWidget {
  const CreationCompteForm({
    super.key,
    required this.matriculeController,
    required this.nomController,
    required this.prenomController,
    required this.emailController,
    required this.telephoneController,
    required this.campus,
    required this.formation,
    required this.niveau,
    required this.classe,
    required this.onCampusChanged,
    required this.onFormationChanged,
    required this.onNiveauChanged,
    required this.onClasseChanged,
  });

  final TextEditingController matriculeController;
  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController emailController;
  final TextEditingController telephoneController;

  final String? campus;
  final String? formation;
  final String? niveau;
  final String? classe;

  final ValueChanged<String?> onCampusChanged;
  final ValueChanged<String?> onFormationChanged;
  final ValueChanged<String?> onNiveauChanged;
  final ValueChanged<String?> onClasseChanged;

  InputDecoration _decoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTextStyles.title.copyWith(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: _decoration(
        hint: hint,
        icon: icon,
      ),
      items: items.map(
            (item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        },
      ).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Veuillez sélectionner une option';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Matricule'),

        TextFormField(
          controller: matriculeController,
          decoration: _decoration(
            hint: 'Votre matricule étudiant',
            icon: Icons.badge_outlined,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Veuillez saisir votre matricule';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        _label('Nom'),

        TextFormField(
          controller: nomController,
          decoration: _decoration(
            hint: 'Votre nom',
            icon: Icons.person_outline_rounded,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Veuillez saisir votre nom';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        _label('Prénom'),

        TextFormField(
          controller: prenomController,
          decoration: _decoration(
            hint: 'Votre prénom',
            icon: Icons.person_outline_rounded,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Veuillez saisir votre prénom';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        _label('Adresse e-mail'),

        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _decoration(
            hint: 'Votre adresse e-mail',
            icon: Icons.email_outlined,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Veuillez saisir votre adresse e-mail';
            }

            return null;
          },
        ),

        const SizedBox(height: 20),

        _label('Téléphone'),

        TextFormField(
          controller: telephoneController,
          keyboardType: TextInputType.phone,
          decoration: _decoration(
            hint: 'Votre numéro de téléphone',
            icon: Icons.phone_outlined,
          ),
        ),

        const SizedBox(height: 20),

        _label('Campus'),

        _dropdown(
          hint: 'Sélectionner le campus',
          icon: Icons.location_on_outlined,
          value: campus,
          items: const [
            'Campus principal',
            'Campus Nord',
            'Campus Sud',
          ],
          onChanged: onCampusChanged,
        ),

        const SizedBox(height: 20),

        _label('Formation'),

        _dropdown(
          hint: 'Sélectionner la formation',
          icon: Icons.school_outlined,
          value: formation,
          items: const [
            'Informatique',
            'Gestion',
            'Réseaux et Télécommunications',
            'Marketing',
          ],
          onChanged: onFormationChanged,
        ),

        const SizedBox(height: 20),

        _label('Niveau'),

        _dropdown(
          hint: 'Sélectionner le niveau',
          icon: Icons.layers_outlined,
          value: niveau,
          items: const [
            '1ère année',
            '2ème année',
            '3ème année',
          ],
          onChanged: onNiveauChanged,
        ),

        const SizedBox(height: 20),

        _label('Classe'),

        _dropdown(
          hint: 'Sélectionner la classe',
          icon: Icons.groups_outlined,
          value: classe,
          items: const [
            'Classe A',
            'Classe B',
            'Classe C',
          ],
          onChanged: onClasseChanged,
        ),
      ],
    );
  }
}