import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Color backgroundColor;

  const OnboardingContent({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 196,
            height: 196,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(42),
            ),
            alignment: Alignment.center,
            child: Text(
              icon,
              style: const TextStyle(
                fontSize: 76,
              ),
            ),
          ),

          const SizedBox(height: 48),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF26384D),
              fontSize: 29,
              height: 1.18,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF91A0AE),
              fontSize: 18,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}