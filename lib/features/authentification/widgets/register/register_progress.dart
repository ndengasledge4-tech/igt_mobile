import 'package:flutter/material.dart';

class RegisterProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const RegisterProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        totalSteps,
            (index) {
          final active = index < currentStep;

          return Expanded(
            child: Container(
              height: 5,
              margin: EdgeInsets.only(
                right: index == totalSteps - 1 ? 0 : 7,
              ),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF4388C5)
                    : const Color(0xFFE0E7ED),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}