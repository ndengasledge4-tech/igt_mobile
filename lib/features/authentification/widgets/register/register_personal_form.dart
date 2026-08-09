import 'package:flutter/material.dart';

class RegisterPersonalForm extends StatelessWidget {
  const RegisterPersonalForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ),

        const SizedBox(height: 18),

        _field(
          label: 'Prénom',
          hint: 'Votre prénom',
          icon: Icons.person_outline_rounded,
        ),

        const SizedBox(height: 18),

        _field(
          label: 'Identifiant étudiant',
          hint: 'Ex : 2024IG001',
          icon: Icons.badge_outlined,
        ),

        const SizedBox(height: 18),

        _field(
          label: 'Email',
          hint: 'email@igt.edu',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 18),

        _field(
          label: 'Téléphone',
          hint: 'Votre numéro de téléphone',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _field({
    required String label,
    required String hint,
    required IconData icon,
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
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF98A2B3),
              fontSize: 15,
            ),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF7E8C9A),
            ),
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

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(
        color: Color(0xFFDDE3EA),
      ),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(
        color: Color(0xFF4388C5),
        width: 1.5,
      ),
    );
  }
}