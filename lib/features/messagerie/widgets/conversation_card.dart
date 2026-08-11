import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

enum ConversationStatus { traite, enCours, ferme }

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.initials,
    required this.subject,
    required this.interlocutor,
    required this.lastMessage,
    required this.date,
    required this.status,
    this.unreadCount = 0,
    this.onTap,
  });

  final String initials;
  final String subject;
  final String interlocutor;
  final String lastMessage;
  final String date;
  final ConversationStatus status;
  final int unreadCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusColors = _StatusColors.from(status);

    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.softBlue,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            interlocutor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.label.copyWith(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: AppTextStyles.caption.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption.copyWith(fontSize: 11),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _StatusPill(
                          label: _statusLabel(status),
                          foreground: statusColors.foreground,
                          background: statusColors.background,
                        ),
                        if (unreadCount > 0) ...[
                          const SizedBox(width: 6),
                          _UnreadBadge(count: unreadCount),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _statusLabel(ConversationStatus status) {
    switch (status) {
      case ConversationStatus.traite:
        return 'Traité';
      case ConversationStatus.enCours:
        return 'En cours';
      case ConversationStatus.ferme:
        return 'Fermé';
    }
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.foreground,
    required this.background,
  });

  final String label;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _StatusColors {
  const _StatusColors({required this.foreground, required this.background});

  final Color foreground;
  final Color background;

  factory _StatusColors.from(ConversationStatus status) {
    switch (status) {
      case ConversationStatus.traite:
        return _StatusColors(
          foreground: AppColors.success,
          background: AppColors.success.withValues(alpha: 0.12),
        );
      case ConversationStatus.enCours:
        return _StatusColors(
          foreground: AppColors.warning,
          background: AppColors.warning.withValues(alpha: 0.14),
        );
      case ConversationStatus.ferme:
        return _StatusColors(
          foreground: AppColors.secondaryText,
          background: AppColors.divider,
        );
    }
  }
}
