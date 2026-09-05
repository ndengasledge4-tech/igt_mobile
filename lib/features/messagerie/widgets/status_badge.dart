import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  String get label {
    return switch (status) {
      'traite' => 'Traité',
      'en-cours' => 'En cours',
      'ferme' => 'Fermé',
      _ => status,
    };
  }

  Color get foreground {
    return switch (status) {
      'traite' => AppColors.success,
      'en-cours' => AppColors.warning,
      'ferme' => AppColors.secondaryText,
      _ => AppColors.primary,
    };
  }

  Color get background {
    return switch (status) {
      'traite' => AppColors.success.withValues(alpha: 0.12),
      'en-cours' => AppColors.warning.withValues(alpha: 0.12),
      'ferme' => AppColors.divider,
      _ => AppColors.softBlue,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.sm,
        vertical: AppDimensions.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
