import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool tonal;
  final Color? color;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.tonal = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: AppDimensions.iconMedium),
      style: IconButton.styleFrom(
        foregroundColor: color ?? (tonal ? scheme.onPrimaryContainer : null),
        backgroundColor: tonal ? scheme.primaryContainer : null,
        minimumSize: const Size(44, 44),
      ),
    );
  }
}
