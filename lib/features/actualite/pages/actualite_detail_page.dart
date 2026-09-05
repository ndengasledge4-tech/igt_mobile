import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../../communication/communication_store.dart';

class ActualiteDetailPage extends StatelessWidget {
  final CommunicationArticle article;
  const ActualiteDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Détail de la publication')),
    body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: MediaQuery.sizeOf(context).width >= 700
                      ? 2.6
                      : 1.55,
                  child: Image.asset(
                    article.imageAsset,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                AppResponsiveContent(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          article.category,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        article.title,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontSize: 28, height: 1.2),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.account_balance_outlined, size: 17),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              article.source,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: context.semanticColors.textSecondary,
                                  ),
                            ),
                          ),
                          Text(
                            _fullDate(article.publishedAt),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: context.semanticColors.textDisabled,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        article.content,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.7),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            color: context.semanticColors.success,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Publication officielle de l’IGT',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: context.semanticColors.textSecondary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

String _fullDate(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year} à ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
