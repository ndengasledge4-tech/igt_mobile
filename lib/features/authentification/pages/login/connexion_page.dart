import 'package:flutter/material.dart';

import '../../widgets/login/login_button.dart';
import '../../widgets/login/login_footer.dart';
import '../../widgets/login/login_form.dart';
import '../../widgets/login/login_header.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            const LoginHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(32, 28, 32, 30),
                child: Column(
                  children: [
                    const LoginForm(),

                    const SizedBox(height: 24),

                    const LoginButton(),

                    const SizedBox(height: 22),

                    const LoginFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}