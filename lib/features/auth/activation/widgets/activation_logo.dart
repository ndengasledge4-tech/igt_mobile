import 'package:flutter/material.dart';

class ActivationLogo extends StatelessWidget {
  const ActivationLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/logo/logo.png",
        width: 110,
        height: 110,
      ),
    );
  }
}