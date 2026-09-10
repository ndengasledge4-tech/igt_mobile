import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class RegisterPersonalForm extends StatelessWidget {
  const RegisterPersonalForm({
    super.key,
    required this.formKey,
    required this.lastNameController,
    required this.firstNameController,
    required this.matriculeController,
    required this.emailController,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController matriculeController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informations personnelles',
            style: TextStyle(
              color: Color(0xFF26384D),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Renseignez les informations liées à votre dossier étudiant.',
            style: TextStyle(
              color: Color(0xFF8A98A8),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 25),
          _field(
            label: 'Nom',
            hint: 'Votre nom',
            icon: Icons.person_outline_rounded,
            controller: lastNameController,
            validator: (value) => Validators.name(value, fieldName: 'Le nom'),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          _field(
            label: 'Prénom',
            hint: 'Votre prénom',
            icon: Icons.person_outline_rounded,
            controller: firstNameController,
            validator: (value) =>
                Validators.name(value, fieldName: 'Le prénom'),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          _field(
            label: 'Identifiant étudiant',
            hint: 'Ex : 2026IG001',
            icon: Icons.badge_outlined,
            controller: matriculeController,
            validator: Validators.matricule,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          _field(
            label: 'Email',
            hint: 'email@igt.edu',
            icon: Icons.mail_outline_rounded,
            controller: emailController,
            validator: Validators.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          _field(
            label: 'Téléphone',
            hint: 'Votre numéro de téléphone',
            icon: Icons.phone_outlined,
            controller: phoneController,
            validator: Validators.phone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget _field({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required TextInputAction textInputAction,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 9),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF98A2B3), fontSize: 15),
            prefixIcon: Icon(icon, color: const Color(0xFF7E8C9A)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 16,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _focusedBorder(),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(13),
    borderSide: const BorderSide(color: Color(0xFFDDE3EA)),
  );

  OutlineInputBorder _focusedBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(13),
    borderSide: const BorderSide(color: Color(0xFF4388C5), width: 1.5),
  );
}
