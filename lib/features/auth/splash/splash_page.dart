import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';
import 'widgets/splash_background.dart';
import 'widgets/splash_loader.dart';
import 'widgets/splash_logo.dart';
import 'widgets/splash_title.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const SplashBackground(),

          SafeArea(
            child: Column(
              children: const [
                Spacer(),

                SplashLogo(),

                SizedBox(height: 24),

                SplashTitle(),

                Spacer(),

                SplashLoader(),

                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
