import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme/semantic_colors.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({super.key});

  Future<void> _open(BuildContext context, Uri uri) async {
    final opened = await launchUrl(uri);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Impossible d'ouvrir ce contact.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(
              Icons.support_agent_rounded,
              size: 40,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              "Besoin d'aide ?",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Si vous n'avez pas reçu votre code d'activation ou si vous rencontrez un problème lors de l'activation de votre compte, contactez le service de la scolarité de l'IGT.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.semanticColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            TextButton.icon(
              onPressed: () => _open(
                context,
                Uri(scheme: 'mailto', path: 'scolarite@igt.edu.cd'),
              ),
              icon: const Icon(Icons.email_outlined, size: 18),
              label: const Text('scolarite@igt.edu.cd'),
            ),
            TextButton.icon(
              onPressed: () =>
                  _open(context, Uri(scheme: 'tel', path: '+242000000000')),
              icon: const Icon(Icons.phone_outlined, size: 18),
              label: const Text('+242 00 000 0000'),
            ),
          ],
        ),
      ),
    );
  }
}
