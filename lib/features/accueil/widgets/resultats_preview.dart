import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ResultatsPreview extends StatelessWidget {
  const ResultatsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
      child: Row(
        children: const [
          Expanded(
            child: ResultCard(value: '15.2/20', label: 'Moyenne'),
          ),
          SizedBox(width: AppDimensions.sm),
          Expanded(
            child: ResultCard(value: '28/30', label: 'Crédits'),
          ),
          SizedBox(width: AppDimensions.sm),
          Expanded(
            child: ResultCard(value: 'Bien', label: 'Mention'),
          ),
        ],
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final String value;
  final String label;

  const ResultCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.title.copyWith(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.xs),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
