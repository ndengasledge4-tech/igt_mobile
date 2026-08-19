import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';

enum AppButtonVariant { primary, secondary, tonal, text, danger }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool expand;

<<<<<<< HEAD
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.expand = true,
  });
=======
  const AppButton({super.key, required this.text, this.onPressed, this.icon});
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93

  @override
  Widget build(BuildContext context) {
    final callback = isLoading ? null : onPressed;
    final label = AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: isLoading
          ? const SizedBox.square(
              key: ValueKey('loading'),
              dimension: AppDimensions.iconSmall,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              key: const ValueKey('label'),
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: AppDimensions.iconSmall),
                  const SizedBox(width: AppDimensions.space8),
                ],
                Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
              ],
            ),
    );
    final scheme = Theme.of(context).colorScheme;

    final button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
        onPressed: callback,
        child: label,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: callback,
        child: label,
      ),
      AppButtonVariant.tonal => FilledButton.tonal(
        onPressed: callback,
        child: label,
      ),
      AppButtonVariant.text => TextButton(onPressed: callback, child: label),
      AppButtonVariant.danger => ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.error,
          foregroundColor: scheme.onError,
        ),
        child: label,
      ),
    };

    return Semantics(
      button: true,
      label: text,
      child: SizedBox(width: expand ? double.infinity : null, child: button),
    );
  }
}
