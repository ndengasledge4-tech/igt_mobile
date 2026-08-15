import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final Color backgroundColor;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final imageSize = size.width < 380 ? 250.0 : 285.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ILLUSTRATION
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.all(28),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                  size: 50,
                  color: Color(0xFF3F88C5),
                );
              },
            ),
          ),

          const SizedBox(height: 28),

          // TITRE
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF26384D),
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.18,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 12),

          // DESCRIPTION
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 330),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF91A0AE),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
