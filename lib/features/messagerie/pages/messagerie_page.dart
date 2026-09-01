import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_header.dart';
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
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  ConversationCategory? _category;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = CommunicationStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final conversations =
            store.conversations.where(_matchesFilters).toList()
              ..sort((a, b) => _lastActivity(b).compareTo(_lastActivity(a)));

        return Scaffold(
          appBar: AppHeader.secondary(
            title: 'Messagerie',
            subtitle: widget.teacherMode
                ? 'Vue enseignant · conversations étudiantes'
                : _unreadLabel(store.unreadMessages),
            actions: [
              IconButton(
                tooltip: 'Rechercher',
                onPressed: () => _searchFocus.requestFocus(),
                icon: const Icon(Icons.search_rounded),
              ),
              if (!widget.teacherMode)
                IconButton(
                  tooltip: 'Nouvelle demande',
                  onPressed: _openNewRequest,
                  icon: const Icon(Icons.edit_square),
                ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              AppResponsiveContent(
                maxWidth: 920,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      key: const Key('conversation-search-field'),
                      controller: _searchController,
                      focusNode: _searchFocus,
                      textInputAction: TextInputAction.search,
                      onChanged: (value) => setState(() => _query = value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: 'Nom, service ou message…',
                        isDense: true,
                        suffixIcon: _query.trim().isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Effacer la recherche',
                                onPressed: _clearSearch,
                                icon: const Icon(Icons.close_rounded),
                              ),
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
                      subtitle: _conversationCount(conversations.length),
                    ),
                    const SizedBox(height: 12),
                    if (conversations.isEmpty)
                      _NoConversationState(onReset: _resetFilters)
                    else
                      _ConversationList(
                        conversations: conversations,
                        onTap: _openConversation,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _matchesFilters(UniversityConversation item) {
    if (_category != null && item.category != _category) return false;
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return true;
    return item.name.toLowerCase().contains(query) ||
        item.role.toLowerCase().contains(query) ||
        item.messages.any(
          (message) =>
              message.text.toLowerCase().contains(query) ||
              message.author.toLowerCase().contains(query),
        );
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _category = null;
    });
  }

  void _openNewRequest() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const NouvelleDemandePage()),
    );
  }

  void _openConversation(UniversityConversation item) {
    CommunicationStore.instance.openConversation(item.id);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ConversationPage(
          conversationId: item.id,
          teacherMode: widget.teacherMode,
        ),
      ),
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

class _ConversationList extends StatelessWidget {
  final List<UniversityConversation> conversations;
  final ValueChanged<UniversityConversation> onTap;

  const _ConversationList({required this.conversations, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: context.semanticColors.border),
      ),
      child: Column(
        children: [
          for (var index = 0; index < conversations.length; index++) ...[
            _ConversationTile(
              item: conversations[index],
              onTap: () => onTap(conversations[index]),
            ),
            if (index != conversations.length - 1)
              Divider(
                height: 1,
                indent: 78,
                color: context.semanticColors.border.withValues(alpha: .72),
              ),
          ],
        ],
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final UniversityConversation item;
  final VoidCallback onTap;

  const _ConversationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final last = item.messages.lastOrNull;
    return InkWell(
      key: Key('conversation-${item.id}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        child: Row(
          children: [
            _ConversationAvatar(item: item),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            if (item.id == 'igt-ai') ...[
                              const SizedBox(width: 7),
                              const _AssistantBadge(),
                            ],
                          ],
                        ),
                      ),
                      if (last != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          _conversationTime(last.sentAt),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 11,
                                color: context.semanticColors.textDisabled,
                              ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.role,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: item.id == 'igt-ai'
                          ? _assistantColor(context)
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          last?.text ?? 'Aucun message pour le moment',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
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
                          constraints: const BoxConstraints(
                            minWidth: 22,
                            minHeight: 22,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          alignment: Alignment.center,
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
      ),
    );
  }
}

class _ConversationAvatar extends StatelessWidget {
  final UniversityConversation item;

  const _ConversationAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    final isAssistant = item.id == 'igt-ai';
    final accent = isAssistant
        ? _assistantColor(context)
        : Theme.of(context).colorScheme.primary;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: isAssistant
              ? Icon(Icons.auto_awesome_rounded, color: accent, size: 22)
              : Text(
                  item.initials,
                  style: TextStyle(color: accent, fontWeight: FontWeight.w700),
                ),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: _statusColor(item.status),
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
}

class _AssistantBadge extends StatelessWidget {
  const _AssistantBadge();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: _assistantColor(context).withValues(alpha: .12),
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      'Assistant',
      style: TextStyle(
        color: _assistantColor(context),
        fontSize: 9,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _NoConversationState extends StatelessWidget {
  final VoidCallback onReset;

  const _NoConversationState({required this.onReset});

  @override
  Widget build(BuildContext context) => AppSurface(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
    child: Center(
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 42,
            color: context.semanticColors.textDisabled,
          ),
          const SizedBox(height: 13),
          Text(
            'Aucune conversation trouvée',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Text(
            'Essayez un autre nom ou réinitialisez les filtres.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.semanticColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          TextButton(onPressed: onReset, child: const Text('Tout afficher')),
        ],
      ),
    ),
  );
}

String _categoryName(ConversationCategory value) => switch (value) {
  ConversationCategory.teachers => 'Enseignants',
  ConversationCategory.administration => 'Administration',
  ConversationCategory.services => 'Services',
  ConversationCategory.groups => 'Groupes',
  ConversationCategory.assistant => 'IGT-IA',
};

Color _assistantColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? const Color(0xFFB9A9FF)
    : const Color(0xFF6550B9);

Color _statusColor(PresenceStatus value) => switch (value) {
  PresenceStatus.online => const Color(0xFF3E9B70),
  PresenceStatus.available => const Color(0xFF5795BF),
  PresenceStatus.away => const Color(0xFFC5913E),
  PresenceStatus.offline => const Color(0xFF98A2B3),
};

DateTime _lastActivity(UniversityConversation value) =>
    value.messages.lastOrNull?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);

String _conversationTime(DateTime value) {
  final diff = DateTime.now().difference(value);
  if (diff.inHours < 24 && diff.inDays == 0) {
    return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }
  if (diff.inDays == 1) return 'Hier';
  return '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}';
}

String _unreadLabel(int count) {
  if (count == 0) return 'Tous vos messages sont lus';
  return '$count message${count > 1 ? 's' : ''} non lu${count > 1 ? 's' : ''}';
}

String _conversationCount(int count) =>
    '$count échange${count > 1 ? 's' : ''} affiché${count > 1 ? 's' : ''}';
