import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
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
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(seconds: 3), _navigate);
  }

  void _navigate() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, RouteNames.onboarding);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
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
