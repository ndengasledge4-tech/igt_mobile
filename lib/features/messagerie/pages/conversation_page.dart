import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/message_bubble.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({
    super.key,
    required this.subject,
    required this.interlocutor,
    required this.initials,
    required this.status,
    required this.messages,
  });

  final String subject;
  final String interlocutor;
  final String initials;
  final String status;
  final List<({String text, String time, bool isSentByUser})> messages;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late final List<({String text, String time, bool isSentByUser})> _messages;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = List<({String text, String time, bool isSentByUser})>.from(
      widget.messages,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add((text: text, time: 'Maintenant', isSentByUser: true));
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _ConversationHeader(
              initials: widget.initials,
              interlocutor: widget.interlocutor,
              subject: widget.subject,
              status: widget.status,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                itemCount: _messages.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final message = _messages[index];

                  return MessageBubble(
                    text: message.text,
                    time: message.time,
                    isSentByUser: message.isSentByUser,
                    initials: widget.initials,
                  );
                },
              ),
            ),
            _MessageComposer(
              controller: _messageController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationHeader extends StatelessWidget {
  const _ConversationHeader({
    required this.initials,
    required this.interlocutor,
    required this.subject,
    required this.status,
  });

  final String initials;
  final String interlocutor;
  final String subject;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 32,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded, size: 16),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.softBlue,
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _HeaderAvatar(initials: initials),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  interlocutor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    _StatusBadge(status: status),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        subject,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(fontSize: 11),
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

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.softBlue,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: AppTextStyles.label.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      'traite' => 'Traité',
      'en-cours' => 'En cours',
      'ferme' => 'Fermé',
      _ => status,
    };

    final foreground = switch (status) {
      'traite' => AppColors.success,
      'en-cours' => AppColors.warning,
      'ferme' => AppColors.secondaryText,
      _ => AppColors.primary,
    };

    final background = switch (status) {
      'traite' => AppColors.success.withValues(alpha: 0.12),
      'en-cours' => AppColors.warning.withValues(alpha: 0.12),
      'ferme' => AppColors.divider,
      _ => AppColors.softBlue,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.text),
              decoration: InputDecoration(
                hintText: 'Écrire un message...',
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.hint,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox.square(
            dimension: 40,
            child: IconButton.filled(
              onPressed: onSend,
              icon: const Icon(Icons.send_rounded, size: 16),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
