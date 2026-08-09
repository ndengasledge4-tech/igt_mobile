import 'package:flutter/material.dart';

class RegisterPasswordForm extends StatefulWidget {
  const RegisterPasswordForm({super.key});

  @override
  State<RegisterPasswordForm> createState() =>
      _RegisterPasswordFormState();
}

class _RegisterPasswordFormState
    extends State<RegisterPasswordForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sécurisez votre compte',
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 7),

        const Text(
          'Définissez le mot de passe qui sera utilisé '
              'pour vous connecter.',
          style: TextStyle(
            color: Color(0xFF8A98A8),
            fontSize: 14,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 25),

        _passwordField(
          label: 'Mot de passe',
          hint: 'Votre mot de passe',
          obscure: _obscurePassword,
          onVisibilityPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),

        const SizedBox(height: 18),

        _passwordField(
          label: 'Confirmer le mot de passe',
          hint: 'Confirmez votre mot de passe',
          obscure: _obscureConfirmation,
          onVisibilityPressed: () {
            setState(() {
              _obscureConfirmation = !_obscureConfirmation;
            });
          },
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F6FB),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conseils de sécurité',
                style: TextStyle(
                  color: Color(0xFF526477),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 9),
              _Rule(text: 'Au moins 8 caractères'),
              _Rule(text: 'Une lettre majuscule'),
              _Rule(text: 'Une lettre minuscule'),
              _Rule(text: 'Un chiffre'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _passwordField({
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback onVisibilityPressed,
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
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF98A2B3),
            ),
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: Color(0xFF7E8C9A),
            ),
            suffixIcon: IconButton(
              onPressed: onVisibilityPressed,
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF7E8C9A),
              ),
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

class _Rule extends StatelessWidget {
  final String text;

  const _Rule({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 6,
            color: Color(0xFF8A98A8),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF7C8A98),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}