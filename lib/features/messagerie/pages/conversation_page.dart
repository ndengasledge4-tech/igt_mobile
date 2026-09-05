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
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                _ChatAvatar(
                  initials: conversation.initials,
                  status: conversation.status,
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${conversation.role} · ${_statusLabel(conversation.status)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          color: context.semanticColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Informations',
                onPressed: () {},
                icon: const Icon(Icons.info_outline_rounded),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
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
                        if (showDate) _DateSeparator(date: message.sentAt),
                        _MessageBubble(message: message, sentByMe: sentByMe),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ),
              _Composer(
                controller: _controller,
                onAttach: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pièce jointe ajoutée en mode prototype'),
                  ),
                ),
                onSend: () {
                  if (_controller.text.trim().isEmpty) return;
                  store.sendMessage(
                    widget.conversationId,
                    _controller.text,
                    asTeacher: widget.teacherMode,
                  );
                  _controller.clear();
                  setState(() {});
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  final String initials;
  final PresenceStatus status;
  const _ChatAvatar({required this.initials, required this.status});
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          initials,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
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
            color: status == PresenceStatus.online
                ? const Color(0xFF3E9B70)
                : const Color(0xFF98A2B3),
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
  const _MessageBubble({required this.message, required this.sentByMe});
  @override
  Widget build(BuildContext context) => Align(
    alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width >= 700
            ? 480
            : MediaQuery.sizeOf(context).width * .78,
      ),
      child: Column(
        crossAxisAlignment: sentByMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            decoration: BoxDecoration(
              color: sentByMe
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
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
            '${message.sentAt.hour.toString().padLeft(2, '0')}:${message.sentAt.minute.toString().padLeft(2, '0')}${sentByMe ? '  ✓✓' : ''}',
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

class _Composer extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onAttach;
  final VoidCallback onSend;
  const _Composer({
    required this.controller,
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
            onPressed: widget.onAttach,
            icon: const Icon(Icons.attach_file_rounded),
          ),
          Expanded(
            child: TextField(
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
            onPressed: widget.controller.text.trim().isEmpty
                ? null
                : widget.onSend,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              disabledBackgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
            ),
            icon: const Icon(Icons.send_rounded),
          ),
        ],
      ),
    ),
  );
}

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
String _dayLabel(DateTime date) {
  final now = DateTime.now();
  if (_sameDay(now, date)) return 'Aujourd’hui';
  if (_sameDay(now.subtract(const Duration(days: 1)), date)) return 'Hier';
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

String _statusLabel(PresenceStatus status) => switch (status) {
  PresenceStatus.online => 'En ligne',
  PresenceStatus.available => 'Disponible',
  PresenceStatus.away => 'Absent',
  PresenceStatus.offline => 'Hors ligne',
};
