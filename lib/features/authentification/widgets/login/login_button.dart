import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 68,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, RouteNames.navigation);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3F88C5),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Se connecter',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
