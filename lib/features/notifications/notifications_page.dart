import 'package:flutter/material.dart';

import '../../app/routes/route_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/semantic_colors.dart';
import '../../shared/widgets/premium_ui.dart';
import '../../shared/widgets/app_header.dart';
import '../../shared/widgets/app_empty_state.dart';
import '../actualite/pages/actualite_detail_page.dart';
import '../actualite/pages/evenement_detail_page.dart';
import '../communication/communication_store.dart';
import '../messagerie/pages/conversation_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = CommunicationStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final groups = _grouped(store.notifications);
        return Scaffold(
          appBar: AppHeader.secondary(
            title: 'Notifications',
            subtitle:
                '${store.unreadNotifications} non lue${store.unreadNotifications > 1 ? 's' : ''}',
            actions: [
              IconButton(
                key: const Key('mark-all-notifications-read'),
                tooltip: 'Tout marquer comme lu',
                onPressed: store.unreadNotifications == 0
                    ? null
                    : store.markAllNotificationsRead,
                icon: const Icon(Icons.done_all_rounded),
              ),
            ],
          ),
          body: groups.isEmpty
              ? const AppEmptyState(
                  icon: Icons.notifications_none_rounded,
                  title: 'Vous êtes à jour',
                  message: 'Aucune nouvelle notification pour le moment.',
                )
              : ListView(
                  padding: const EdgeInsets.only(bottom: 32),
                  children: [
                    for (final entry in groups.entries) ...[
                      AppResponsiveContent(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: AppSectionHeading(
                          title: entry.key,
                          subtitle:
                              '${entry.value.length} notification${entry.value.length > 1 ? 's' : ''}',
                        ),
                      ),
                      AppResponsiveContent(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            for (final item in entry.value)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _NotificationCard(
                                  item: item,
                                  onTap: () {
                                    store.markNotificationRead(item.id);
                                    _showDetail(context, item);
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
        );
      },
    );
  }

  Map<String, List<CommunicationNotification>> _grouped(
    List<CommunicationNotification> items,
  ) {
    final now = DateTime.now();
    final startToday = DateTime(now.year, now.month, now.day);
    final result = <String, List<CommunicationNotification>>{};
    for (final item in items) {
      final age = startToday
          .difference(DateTime(item.date.year, item.date.month, item.date.day))
          .inDays;
      final label = age <= 0
          ? 'Aujourd’hui'
          : age <= 7
          ? 'Cette semaine'
          : 'Plus ancien';
      result.putIfAbsent(label, () => []).add(item);
    }
    return result;
  }

  void _showDetail(BuildContext context, CommunicationNotification item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _NotificationIdentity(kind: item.kind, large: true),
              const SizedBox(height: 18),
              Text(
                item.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '${_fullDate(item.date)} · ${item.source}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item.content,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.55),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _openDestination(context, item);
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(_actionLabel(item.destination)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDestination(BuildContext context, CommunicationNotification item) {
    final store = CommunicationStore.instance;
    switch (item.destination) {
      case NotificationDestination.planning:
        Navigator.pushNamed(context, RouteNames.emploiDuTemps);
      case NotificationDestination.result:
        Navigator.pushNamed(context, RouteNames.mesResultats);
      case NotificationDestination.document:
        Navigator.pushNamed(context, RouteNames.mesDocuments);
      case NotificationDestination.conversation:
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ConversationPage(
              conversationId: item.targetId ?? 'teacher-mariam',
            ),
          ),
        );
      case NotificationDestination.news:
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ActualiteDetailPage(
              article: store.articleById(item.targetId ?? 'rentree'),
            ),
          ),
        );
      case NotificationDestination.event:
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => EvenementDetailPage(
              event: store.eventById(item.targetId ?? 'forum'),
            ),
          ),
        );
    }
  }
}

class _NotificationCard extends StatelessWidget {
  final CommunicationNotification item;
  final VoidCallback onTap;
  const _NotificationCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) => AppSurface(
    onTap: onTap,
    color: item.unread
        ? Theme.of(context).colorScheme.primary.withValues(alpha: .055)
        : null,
    padding: const EdgeInsets.all(15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NotificationIdentity(kind: item.kind),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  if (item.unread)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                item.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      item.source,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: context.semanticColors.textDisabled,
                      ),
                    ),
                  ),
                  Text(
                    ' · ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: context.semanticColors.textDisabled,
                    ),
                  ),
                  Text(
                    _relativeTime(item.date),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: context.semanticColors.textDisabled,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _NotificationIdentity extends StatelessWidget {
  final CommunicationNotificationKind kind;
  final bool large;
  const _NotificationIdentity({required this.kind, this.large = false});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (kind) {
      CommunicationNotificationKind.courseMoved => (
        Icons.edit_calendar_rounded,
        const Color(0xFFB87512),
      ),
      CommunicationNotificationKind.courseCancelled => (
        Icons.event_busy_rounded,
        Theme.of(context).colorScheme.error,
      ),
      CommunicationNotificationKind.result => (
        Icons.workspace_premium_rounded,
        context.semanticColors.success,
      ),
      CommunicationNotificationKind.document => (
        Icons.description_rounded,
        context.semanticColors.info,
      ),
      CommunicationNotificationKind.message => (
        Icons.chat_bubble_rounded,
        const Color(0xFF2F7D78),
      ),
      CommunicationNotificationKind.announcement => (
        Icons.campaign_rounded,
        const Color(0xFF9A645D),
      ),
      CommunicationNotificationKind.event => (
        Icons.event_rounded,
        const Color(0xFF67558A),
      ),
      CommunicationNotificationKind.administrative => (
        Icons.account_balance_rounded,
        AppColors.primary,
      ),
    };
    final size = large ? 54.0 : 44.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .11),
        borderRadius: BorderRadius.circular(large ? 17 : 14),
      ),
      child: Icon(icon, color: color, size: large ? 27 : 21),
    );
  }
}

String _relativeTime(DateTime date) {
  final difference = DateTime.now().difference(date);
  if (difference.inMinutes < 2) return 'À l’instant';
  if (difference.inHours < 1) return 'Il y a ${difference.inMinutes} min';
  if (difference.inHours < 24) return 'Il y a ${difference.inHours} h';
  if (difference.inDays == 1) return 'Hier';
  return 'Il y a ${difference.inDays} j';
}

String _fullDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} · ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

String _actionLabel(NotificationDestination destination) =>
    switch (destination) {
      NotificationDestination.planning => 'Ouvrir le planning',
      NotificationDestination.result => 'Ouvrir le résultat',
      NotificationDestination.document => 'Ouvrir les documents',
      NotificationDestination.conversation => 'Ouvrir la conversation',
      NotificationDestination.news => 'Lire l’annonce',
      NotificationDestination.event => 'Voir l’événement',
    };
