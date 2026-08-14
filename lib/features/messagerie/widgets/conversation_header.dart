import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import 'initials_avatar.dart';
import 'status_badge.dart';

class ConversationHeader extends StatelessWidget {
  const ConversationHeader({
    super.key,
    required this.initials,
    required this.interlocutor,
    required this.subject,
    required this.status,
    required this.onBack,
  });

  final String initials;
  final String interlocutor;
  final String subject;
  final String status;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 40,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: AppDimensions.iconSmall,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.softBlue,
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: AppDimensions.sm),

          InitialsAvatar(
            initials: initials,
            size: 36,
          ),

          const SizedBox(width: AppDimensions.sm),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  interlocutor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label,
                ),

                const SizedBox(height: AppDimensions.xs),

                Row(
                  children: [
                    StatusBadge(status: status),

                    const SizedBox(width: AppDimensions.xs),

                    Expanded(
                      child: Text(
                        subject,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption,
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