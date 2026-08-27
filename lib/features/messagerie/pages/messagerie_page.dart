import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../../communication/communication_store.dart';
import 'conversation_page.dart';
import 'nouvelle_demande_page.dart';

class MessageriePage extends StatefulWidget {
  final bool teacherMode;
  const MessageriePage({super.key, this.teacherMode = false});

  @override
  State<MessageriePage> createState() => _MessageriePageState();
}

class _MessageriePageState extends State<MessageriePage> {
  ConversationCategory? _category;

  @override
  Widget build(BuildContext context) {
    final store = CommunicationStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final conversations = store.conversations
            .where((item) => _category == null || item.category == _category)
            .toList();
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Messagerie'),
                Text(
                  widget.teacherMode
                      ? 'Vue enseignant · conversations étudiantes'
                      : '${store.unreadMessages} message${store.unreadMessages > 1 ? 's' : ''} non lu${store.unreadMessages > 1 ? 's' : ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ],
            ),
            actions: [
              if (!widget.teacherMode)
                IconButton(
                  tooltip: 'Nouvelle demande',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const NouvelleDemandePage(),
                    ),
                  ),
                  icon: const Icon(Icons.edit_square),
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              AppResponsiveContent(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: 'Rechercher une conversation',
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _Filter(
                            label: 'Toutes',
                            selected: _category == null,
                            onTap: () => setState(() => _category = null),
                          ),
                          for (final category in ConversationCategory.values)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: _Filter(
                                label: _categoryName(category),
                                selected: _category == category,
                                onTap: () =>
                                    setState(() => _category = category),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppSectionHeading(
                      title: 'Conversations',
                      subtitle:
                          '${conversations.length} échange${conversations.length > 1 ? 's' : ''}',
                    ),
                    const SizedBox(height: 12),
                    for (final item in conversations)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _ConversationTile(
                          item: item,
                          onTap: () {
                            store.openConversation(item.id);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => ConversationPage(
                                  conversationId: item.id,
                                  teacherMode: widget.teacherMode,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: widget.teacherMode
              ? null
              : FloatingActionButton.extended(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const NouvelleDemandePage(),
                    ),
                  ),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Nouvelle demande'),
                ),
        );
      },
    );
  }
}

class _Filter extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Filter({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => ChoiceChip(
    label: Text(label),
    selected: selected,
    showCheckmark: false,
    onSelected: (_) => onTap(),
  );
}

class _ConversationTile extends StatelessWidget {
  final UniversityConversation item;
  final VoidCallback onTap;
  const _ConversationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final last = item.messages.last;
    return AppSurface(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _Avatar(initials: item.initials, status: item.status),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      _conversationTime(last.sentAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: context.semanticColors.textDisabled,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  item.role,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        last.text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.semanticColors.textSecondary,
                          fontWeight: item.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    if (item.unreadCount > 0)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          '${item.unreadCount}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
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
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final PresenceStatus status;
  const _Avatar({required this.initials, required this.status});
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          initials,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Positioned(
        right: -1,
        bottom: -1,
        child: Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            color: _statusColor(status),
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.surface,
              width: 2,
            ),
          ),
        ),
      ),
    ],
  );
}

String _categoryName(ConversationCategory value) => switch (value) {
  ConversationCategory.teachers => 'Enseignants',
  ConversationCategory.administration => 'Administration',
  ConversationCategory.services => 'Services',
  ConversationCategory.groups => 'Groupes',
};
Color _statusColor(PresenceStatus value) => switch (value) {
  PresenceStatus.online => const Color(0xFF3E9B70),
  PresenceStatus.available => const Color(0xFF5795BF),
  PresenceStatus.away => const Color(0xFFC5913E),
  PresenceStatus.offline => const Color(0xFF98A2B3),
};
String _conversationTime(DateTime value) {
  final diff = DateTime.now().difference(value);
  if (diff.inHours < 24) {
    return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }
  if (diff.inDays == 1) return 'Hier';
  return '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}';
}
