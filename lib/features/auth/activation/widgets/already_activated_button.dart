import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';

class AlreadyActivatedButton extends StatelessWidget {
  const AlreadyActivatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.login,
        );
      },
      child: const Text(
        "J'ai déjà activé mon compte",
      ),
    );
  }
}