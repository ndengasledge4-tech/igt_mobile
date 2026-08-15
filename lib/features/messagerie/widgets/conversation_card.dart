import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import 'initials_avatar.dart';
import 'status_badge.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.initials,
    required this.subject,
    required this.interlocutor,
    required this.lastMessage,
    required this.date,
    required this.status,
    required this.unreadCount,
    this.onTap,
  });

  final String initials;
  final String subject;
  final String interlocutor;
  final String lastMessage;
  final String date;
  final String status;
  final int unreadCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Row(
            children: [
              InitialsAvatar(initials: initials, size: 42),

              const SizedBox(width: AppDimensions.sm),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            interlocutor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.label,
                          ),
                        ),

                        const SizedBox(width: AppDimensions.sm),

                        Text(date, style: AppTextStyles.caption),
                      ],
                    ),

                    const SizedBox(height: AppDimensions.xs),

                    Text(
                      subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.xs),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption,
                          ),
                        ),

                        const SizedBox(width: AppDimensions.xs),

                        StatusBadge(status: status),

                        if (unreadCount > 0) ...[
                          const SizedBox(width: AppDimensions.xs),
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
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 18),
      height: 18,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xs),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Text(
        '$count',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
