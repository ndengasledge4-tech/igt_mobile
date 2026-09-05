import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final bool destructive;

  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmLabel = 'Confirmer',
    this.cancelLabel = 'Annuler',
    this.onConfirm,
    this.destructive = false,
  });

  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirmer',
    bool destructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: Text(message),
        confirmLabel: confirmLabel,
        destructive: destructive,
        onConfirm: () => Navigator.pop(context, true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel),
        ),
        TextButton(
          onPressed: onConfirm,
          style: destructive
              ? TextButton.styleFrom(foregroundColor: scheme.error)
              : null,
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
