import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

class RegisterStepIndicator extends StatelessWidget {
  final int currentStep;

  const RegisterStepIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _circle(1),

            Expanded(
              child: Divider(
                thickness: 2,
                color: currentStep >= 2
                    ? AppColors.primary
                    : Colors.grey.shade300,
              ),
            ),

            _circle(2),

            Expanded(
              child: Divider(
                thickness: 2,
                color: currentStep >= 3
                    ? AppColors.primary
                    : Colors.grey.shade300,
              ),
            ),

            _circle(3),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: Text(
                "Personnel",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: currentStep == 1
                      ? AppColors.primary
                      : AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: Text(
                "Académique",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: currentStep == 2
                      ? AppColors.primary
                      : AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: Text(
                "Sécurité",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: currentStep == 3
                      ? AppColors.primary
                      : AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _circle(int step) {
    final bool active = currentStep >= step;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: active
            ? AppColors.primary
            : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: active
              ? AppColors.primary
              : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          "$step",
          style: TextStyle(
            color: active
                ? Colors.white
                : AppColors.secondaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}