import 'package:flutter/material.dart';

import '../../app/theme/semantic_colors.dart';
import '../../mock/mock_notifications.dart';
import 'widgets/notification_app_bar.dart';
import 'widgets/notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final semantic = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final notifications = MockNotificationsData.items;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const NotificationAppBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  final (icon, color) = switch (item.kind) {
                    MockNotificationKind.result => (
                      Icons.workspace_premium_outlined,
                      semantic.success,
                    ),
                    MockNotificationKind.document => (
                      Icons.description_outlined,
                      semantic.info,
                    ),
                    MockNotificationKind.news => (
                      Icons.campaign_outlined,
                      scheme.tertiary,
                    ),
                    MockNotificationKind.schedule => (
                      Icons.event_outlined,
                      semantic.warning,
                    ),
                    MockNotificationKind.warning => (
                      Icons.error_outline_rounded,
                      scheme.error,
                    ),
                  };
                  return NotificationTile(
                    title: item.title,
                    subtitle: item.message,
                    time: item.time,
                    icon: icon,
                    color: color,
                    unread: item.unread,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
