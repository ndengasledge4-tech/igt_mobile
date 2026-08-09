import 'package:flutter/material.dart';

class RegisterLogo extends StatelessWidget {
  const RegisterLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/logo/logo.png",
        width: 110,
        height: 110,
        fit: BoxFit.contain,
      ),
    );
  }
}