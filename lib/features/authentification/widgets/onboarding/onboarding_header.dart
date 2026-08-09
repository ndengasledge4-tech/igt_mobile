import 'package:flutter/material.dart';

import '../../../../app/theme/text_styles.dart';

class OnboardingHeader extends StatelessWidget {
  final VoidCallback onSkip;

  const OnboardingHeader({
    super.key,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Passer',
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFF8A99A8),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}