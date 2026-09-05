import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/dimensions.dart';
import '../../../mock/mock_news.dart';
import '../../../shared/widgets/app_badge.dart';

class AnnouncementCard extends StatelessWidget {
  final MockNewsItem item;

  const AnnouncementCard({super.key, this.item = MockNewsData.announcement});

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
            Stack(
              children: [
                Image.asset(
                  item.imageAsset,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: AppDimensions.space12,
                  left: AppDimensions.space12,
                  child: AppBadge(
                    label: item.category,
                    tone: AppBadgeTone.warning,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppDimensions.space8),
                  Text(
                    item.excerpt,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space16),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppDimensions.space4),
                      Expanded(
                        child: Text(
                          item.date,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
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
