import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';
import '../../app/theme/semantic_colors.dart';

enum AppBadgeTone { neutral, primary, success, warning, error, info }

class AppBadge extends StatelessWidget {
  final String label;
  final AppBadgeTone tone;
  final IconData? icon;

  const AppBadge({
    super.key,
    required this.label,
    this.tone = AppBadgeTone.neutral,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final semantic = context.semanticColors;
    final color = switch (tone) {
      AppBadgeTone.neutral => semantic.textSecondary,
      AppBadgeTone.primary => scheme.primary,
      AppBadgeTone.success => semantic.success,
      AppBadgeTone.warning => semantic.warning,
      AppBadgeTone.error => scheme.error,
      AppBadgeTone.info => semantic.info,
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space8,
        vertical: AppDimensions.space4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: AppDimensions.space4),
          ],
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
