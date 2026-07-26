import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/salles/igt.jpg',
          fit: BoxFit.cover,
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(30, 90, 153, .70),
                Color.fromRGBO(47, 109, 181, .80),
                Color.fromRGBO(13, 27, 42, .90),
              ],
            ),
          ),
        ),
      ],
    );
  }
}