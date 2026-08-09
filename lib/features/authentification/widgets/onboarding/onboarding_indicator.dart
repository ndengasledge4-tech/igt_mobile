import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
            (index) {
          final selected = index == currentIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: selected ? 34 : 11,
            height: 11,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF3F88C5)
                  : const Color(0xFFE1E8EF),
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}