import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import 'initials_avatar.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isSentByUser,
    this.initials,
  });

  final String text;
  final String time;
  final bool isSentByUser;
  final String? initials;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width * 0.75;

    return Row(
      mainAxisAlignment: isSentByUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isSentByUser) ...[
          InitialsAvatar(
            initials: initials ?? '',
            size: 28,
          ),
          const SizedBox(width: AppDimensions.sm),
        ],

        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: Column(
              crossAxisAlignment: isSentByUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.md,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSentByUser
                        ? AppColors.primary
                        : AppColors.card,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(
                        isSentByUser ? 16 : 4,
                      ),
                      bottomRight: Radius.circular(
                        isSentByUser ? 4 : 16,
                      ),
                    ),
                    border: isSentByUser
                        ? null
                        : Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Text(
                    text,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isSentByUser
                          ? AppColors.white
                          : AppColors.text,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.xs),

                Text(
                  time,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}