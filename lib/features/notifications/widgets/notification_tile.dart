import 'package:flutter/material.dart';

import 'notification_icon.dart';
import 'notification_subtitle.dart';
import 'notification_time.dart';
import 'notification_title.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
  final bool unread;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: unread
              ? theme.colorScheme.primaryContainer.withValues(alpha: 0.35)
              : theme.colorScheme.surface,
          border: Border(
            bottom: BorderSide(color: theme.dividerColor, width: .6),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationIcon(icon: icon, color: color),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: NotificationTitle(title: title)),

                      NotificationTime(time: time),
                    ],
                  ),

                  const SizedBox(height: 6),

                  NotificationSubtitle(subtitle: subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
