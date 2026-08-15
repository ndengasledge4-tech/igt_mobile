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
      children: List.generate(count, (index) {
        final selected = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: selected ? 28 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF3F88C5) : const Color(0xFFDCE4EB),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
