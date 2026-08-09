import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Identifiant / Email',
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          decoration: InputDecoration(
            hintText: 'ex: 2024IG001 ou email@igt.edu',
            prefixIcon: const Icon(Icons.mail_outline),
            filled: true,
            fillColor: Colors.white,
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _focusedBorder(),
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          'Mot de passe',
          style: TextStyle(
            color: Color(0xFF26384D),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Votre mot de passe',
            prefixIcon: const Icon(Icons.lock_outline),
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
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Color(0xFFDCE3E9),
      ),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Color(0xFF3F88C5),
        width: 1.5,
      ),
    );
  }
}