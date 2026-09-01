import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../communication/communication_store.dart';

class ConversationPage extends StatefulWidget {
  final String conversationId;
  final bool teacherMode;

  const ConversationPage({
    super.key,
    required this.conversationId,
    this.teacherMode = false,
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSending = false;
  bool _assistantIsReplying = false;
  String? _deliveryStatus;

  @override
  void initState() {
    super.initState();
    CommunicationStore.instance.openConversation(widget.conversationId);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = CommunicationStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final conversation = store.conversationById(widget.conversationId);
        final isGroup = conversation.id == 'group-l3';
        final isAssistant = conversation.id == 'igt-ai';
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                _ChatAvatar(conversation: conversation),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              conversation.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          if (isAssistant) ...[
                            const SizedBox(width: 7),
                            const _HeaderAssistantBadge(),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${conversation.role} · ${_statusLabel(conversation.status)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.72),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                key: const Key('conversation-information-button'),
                tooltip: 'Informations',
                onPressed: () => _showConversationInfo(conversation),
                icon: const Icon(Icons.info_outline_rounded),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: Column(
                children: [
                  Expanded(
                    child: conversation.messages.isEmpty
                        ? const _EmptyConversation()
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
                            itemCount: conversation.messages.length,
                            itemBuilder: (context, index) {
                              final message = conversation.messages[index];
                              final previous = index > 0
                                  ? conversation.messages[index - 1]
                                  : null;
                              final showDate =
                                  previous == null ||
                                  !_sameDay(previous.sentAt, message.sentAt);
                              final sentByMe = widget.teacherMode
                                  ? !message.sentByStudent
                                  : message.sentByStudent;
                              return Column(
                                children: [
                                  if (showDate)
                                    _DateSeparator(date: message.sentAt),
                                  _MessageBubble(
                                    message: message,
                                    sentByMe: sentByMe,
                                    showAuthor: isGroup && !sentByMe,
                                    fromAssistant:
                                        isAssistant && !message.sentByStudent,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              );
                            },
                          ),
                  ),
                  if (_assistantIsReplying)
                    const _ConversationProgress(
                      icon: Icons.auto_awesome_rounded,
                      label: 'IGT-IA prépare une réponse simulée…',
                      assistant: true,
                    )
                  else if (_deliveryStatus != null)
                    _ConversationProgress(
                      icon: _isSending
                          ? Icons.schedule_rounded
                          : Icons.check_circle_outline_rounded,
                      label: _deliveryStatus!,
                    ),
                  _Composer(
                    controller: _controller,
                    sending: _isSending,
                    onAttach: _showAttachmentSheet,
                    onSend: () => _sendMessage(conversation),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _sendMessage(UniversityConversation conversation) {
    final message = _controller.text.trim();
    if (message.isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
      _deliveryStatus = 'Envoi en cours…';
    });
    CommunicationStore.instance.sendMessage(
      conversation.id,
      message,
      asTeacher: widget.teacherMode,
    );
    _controller.clear();
    _scrollToBottom();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final expectsAssistant =
          conversation.id == 'igt-ai' && !widget.teacherMode;
      setState(() {
        _isSending = false;
        _deliveryStatus = 'Message envoyé';
        _assistantIsReplying = expectsAssistant;
      });
      if (!expectsAssistant) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        CommunicationStore.instance.sendServiceReply(
          conversation.id,
          CommunicationStore.instance.assistantReplyFor(message),
          author: 'IGT-IA',
        );
        setState(() => _assistantIsReplying = false);
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _showConversationInfo(UniversityConversation conversation) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ConversationInfoSheet(conversation: conversation),
    );
  }

  void _showAttachmentSheet() {
    showModalBottomSheet<String>(
      context: context,
      builder: (sheetContext) => SafeArea(
        key: const Key('attachment-options-sheet'),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Joindre un fichier',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              Text(
                'Choisissez une source pour cette démonstration.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              _AttachmentOption(
                icon: Icons.description_outlined,
                label: 'Document',
                onTap: () => Navigator.pop(sheetContext, 'Document'),
              ),
              _AttachmentOption(
                icon: Icons.image_outlined,
                label: 'Photo',
                onTap: () => Navigator.pop(sheetContext, 'Photo'),
              ),
              _AttachmentOption(
                icon: Icons.camera_alt_outlined,
                label: 'Appareil photo',
                onTap: () => Navigator.pop(sheetContext, 'Appareil photo'),
              ),
            ],
          ),
        ),
      ),
    ).then((selection) {
      if (!mounted || selection == null) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$selection ajouté en mode prototype')),
      );
    });
  }
}

class _ChatAvatar extends StatelessWidget {
  final UniversityConversation conversation;

  const _ChatAvatar({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final isAssistant = conversation.id == 'igt-ai';
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .14),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.white.withValues(alpha: .18)),
          ),
          child: isAssistant
              ? const Icon(
                  Icons.auto_awesome_rounded,
                  color: Color(0xFFD8CFFF),
                  size: 19,
                )
              : Text(
                  conversation.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: _statusColor(conversation.status),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderAssistantBadge extends StatelessWidget {
  const _HeaderAssistantBadge();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFD8CFFF).withValues(alpha: .18),
      borderRadius: BorderRadius.circular(99),
    ),
    child: const Text(
      'Assistant',
      style: TextStyle(
        color: Color(0xFFE7E1FF),
        fontSize: 9,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _DateSeparator extends StatelessWidget {
  final DateTime date;

  const _DateSeparator({required this.date});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Row(
      children: [
        Expanded(child: Divider(color: Theme.of(context).dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            _dayLabel(date),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: context.semanticColors.textDisabled,
            ),
          ),
        ),
        Expanded(child: Divider(color: Theme.of(context).dividerColor)),
      ],
    ),
  );
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool sentByMe;
  final bool showAuthor;
  final bool fromAssistant;

  const _MessageBubble({
    required this.message,
    required this.sentByMe,
    required this.showAuthor,
    required this.fromAssistant,
  });

  @override
  Widget build(BuildContext context) {
    final assistantColor = _assistantColor(context);
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width >= 700
              ? 520
              : MediaQuery.sizeOf(context).width * .8,
        ),
        child: Column(
          crossAxisAlignment: sentByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (showAuthor || fromAssistant) ...[
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 5),
                child: Text(
                  message.author,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: fromAssistant
                        ? assistantColor
                        : context.semanticColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
              decoration: BoxDecoration(
                color: sentByMe
                    ? Theme.of(context).colorScheme.primary
                    : fromAssistant
                    ? assistantColor.withValues(alpha: .11)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                border: fromAssistant
                    ? Border.all(color: assistantColor.withValues(alpha: .25))
                    : null,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(17),
                  topRight: const Radius.circular(17),
                  bottomLeft: Radius.circular(sentByMe ? 17 : 5),
                  bottomRight: Radius.circular(sentByMe ? 5 : 17),
                ),
              ),
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: sentByMe
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sentByMe
                  ? '${_time(message.sentAt)} · Lu ✓✓'
                  : _time(message.sentAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: context.semanticColors.textDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationProgress extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool assistant;

  const _ConversationProgress({
    required this.icon,
    required this.label,
    this.assistant = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 7, 18, 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          icon,
          size: 14,
          color: assistant
              ? _assistantColor(context)
              : context.semanticColors.textSecondary,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: assistant
                  ? _assistantColor(context)
                  : context.semanticColors.textSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}

class _Composer extends StatefulWidget {
  final TextEditingController controller;
  final bool sending;
  final VoidCallback onAttach;
  final VoidCallback onSend;

  const _Composer({
    required this.controller,
    required this.sending,
    required this.onAttach,
    required this.onSend,
  });

  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
  }

  @override
  void didUpdateWidget(covariant _Composer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == widget.controller) return;
    oldWidget.controller.removeListener(_refresh);
    widget.controller.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Joindre un fichier',
            onPressed: widget.sending ? null : widget.onAttach,
            icon: const Icon(Icons.attach_file_rounded),
          ),
          Expanded(
            child: TextField(
              key: const Key('message-composer-field'),
              controller: widget.controller,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Écrire un message…',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Envoyer',
            onPressed: widget.controller.text.trim().isEmpty || widget.sending
                ? null
                : widget.onSend,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              disabledBackgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
            ),
            icon: widget.sending
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_rounded),
          ),
        ],
      ),
    ),
  );
}

class _EmptyConversation extends StatelessWidget {
  const _EmptyConversation();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 44,
            color: context.semanticColors.textDisabled,
          ),
          const SizedBox(height: 14),
          Text(
            'Aucun message pour le moment',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Text(
            'Écrivez le premier message pour démarrer la conversation.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.semanticColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}

class _ConversationInfoSheet extends StatelessWidget {
  final UniversityConversation conversation;

  const _ConversationInfoSheet({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final isGroup = conversation.id == 'group-l3';
    final isAssistant = conversation.id == 'igt-ai';
    return SafeArea(
      key: Key(isGroup ? 'group-information-sheet' : 'conversation-info-sheet'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 4, 22, 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        (isAssistant
                                ? _assistantColor(context)
                                : Theme.of(context).colorScheme.primary)
                            .withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    isGroup
                        ? Icons.groups_2_rounded
                        : isAssistant
                        ? Icons.auto_awesome_rounded
                        : Icons.account_balance_rounded,
                    color: isAssistant
                        ? _assistantColor(context)
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        conversation.role,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.semanticColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            if (isGroup) ...[
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(icon: Icons.school_rounded, label: 'Licence 3'),
                  _InfoChip(
                    icon: Icons.computer_rounded,
                    label: 'Génie Informatique',
                  ),
                  _InfoChip(
                    icon: Icons.meeting_room_rounded,
                    label: 'Groupe A',
                  ),
                  _InfoChip(icon: Icons.people_rounded, label: '42 membres'),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Quelques membres',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              const _MemberTile(
                initials: 'GK',
                name: 'Grâce K.',
                role: 'Déléguée',
              ),
              const _MemberTile(
                initials: 'DN',
                name: 'David N.',
                role: 'Étudiant',
              ),
              const _MemberTile(initials: 'AM', name: 'Aymen M.', role: 'Vous'),
              const _MemberTile(
                initials: 'FN',
                name: 'Fatou N.',
                role: 'Étudiante',
              ),
            ] else if (isAssistant) ...[
              _InformationNotice(
                icon: Icons.info_outline_rounded,
                color: _assistantColor(context),
                text:
                    'IGT-IA est un assistant institutionnel de démonstration. Ses réponses sont entièrement mockées et aucune donnée n’est envoyée à un modèle externe.',
              ),
            ] else ...[
              _InformationNotice(
                icon: Icons.lock_outline_rounded,
                color: Theme.of(context).colorScheme.primary,
                text:
                    'Cette conversation de démonstration est visible uniquement par l’étudiant et le service concerné.',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 7),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}

class _MemberTile extends StatelessWidget {
  final String initials;
  final String name;
  final String role;

  const _MemberTile({
    required this.initials,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(child: Text(initials)),
    title: Text(name),
    subtitle: Text(role),
  );
}

class _InformationNotice extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _InformationNotice({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: color.withValues(alpha: .2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 21),
        const SizedBox(width: 11),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
          ),
        ),
      ],
    ),
  );
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.primary),
    ),
    title: Text(label),
    trailing: const Icon(Icons.chevron_right_rounded),
    onTap: onTap,
  );
}

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

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

String _dayLabel(DateTime date) {
  final now = DateTime.now();
  if (_sameDay(now, date)) return 'Aujourd’hui';
  if (_sameDay(now.subtract(const Duration(days: 1)), date)) return 'Hier';
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

String _time(DateTime value) =>
    '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

String _statusLabel(PresenceStatus status) => switch (status) {
  PresenceStatus.online => 'En ligne',
  PresenceStatus.available => 'Disponible',
  PresenceStatus.away => 'Absent',
  PresenceStatus.offline => 'Hors ligne',
};
