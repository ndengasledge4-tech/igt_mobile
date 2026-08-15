import 'package:flutter/material.dart';

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({super.key});

  @override
  State<PasswordResetForm> createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nouveau mot de passe',
          style: TextStyle(
            color: Color(0xFF263238),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Votre nouveau mot de passe',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _focusedBorder(),
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          'Confirmer le mot de passe',
          style: TextStyle(
            color: Color(0xFF263238),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: _obscureConfirmation,
          decoration: InputDecoration(
            hintText: 'Confirmez votre mot de passe',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmation = !_obscureConfirmation;
                });
              },
              icon: Icon(
                _obscureConfirmation
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _focusedBorder(),
          ),
        ),

        const SizedBox(height: 18),

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
                'Votre mot de passe doit contenir :',
                style: TextStyle(
                  color: Color(0xFF526477),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              _PasswordRule(text: 'Au moins 8 caractères'),
              _PasswordRule(text: 'Une lettre majuscule'),
              _PasswordRule(text: 'Une lettre minuscule'),
              _PasswordRule(text: 'Un chiffre'),
            ],
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFDDE3EA)),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF4388C5), width: 1.5),
    );
  }
}

class _PasswordRule extends StatelessWidget {
  final String text;

  const _PasswordRule({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Color(0xFF8A98A8)),
          const SizedBox(width: 9),
          Text(
            text,
            style: const TextStyle(color: Color(0xFF7C8A98), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
