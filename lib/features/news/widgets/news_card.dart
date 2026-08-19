import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/dimensions.dart';
import '../../../mock/mock_news.dart';
import '../../../shared/widgets/app_badge.dart';

class NewsCard extends StatelessWidget {
  final MockNewsItem item;

  const NewsCard({super.key, this.item = MockNewsData.featured});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, RouteNames.newsDetail),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.imageAsset,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 170,
                color: theme.colorScheme.surfaceContainerHighest,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined, size: 36),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBadge(label: item.category, tone: AppBadgeTone.success),
                  const SizedBox(height: AppDimensions.space12),
                  Text(item.title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppDimensions.space8),
                  Text(
                    item.excerpt,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space16),
                  Wrap(
                    spacing: AppDimensions.space16,
                    runSpacing: AppDimensions.space8,
                    children: [
                      _Metadata(icon: Icons.calendar_today, label: item.date),
                      _Metadata(icon: Icons.access_time, label: item.time),
                    ],
                  ),
                  const Divider(height: AppDimensions.space32),
                  Row(
                    children: [
                      _Metadata(
                        icon: Icons.favorite_border_rounded,
                        label: '${item.likes}',
                      ),
                      const SizedBox(width: AppDimensions.space16),
                      _Metadata(
                        icon: Icons.mode_comment_outlined,
                        label: '${item.comments}',
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, RouteNames.newsDetail),
                        child: const Text('Lire la suite'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metadata extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Metadata({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: AppDimensions.space4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
