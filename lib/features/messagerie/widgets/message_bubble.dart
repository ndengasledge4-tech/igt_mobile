import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isSentByUser,
  });

  final String text;
  final String time;
  final bool isSentByUser;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isSentByUser ? AppColors.primary : Colors.white;
    final textColor = isSentByUser ? Colors.white : AppColors.text;
    final timeColor = isSentByUser
        ? Colors.white.withValues(alpha: 0.78)
        : AppColors.secondaryText;

    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.74,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(8),
              topRight: const Radius.circular(8),
              bottomLeft: Radius.circular(isSentByUser ? 8 : 2),
              bottomRight: Radius.circular(isSentByUser ? 2 : 8),
            ),
            border: isSentByUser ? null : Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: AppTextStyles.bodySmall.copyWith(
                  color: textColor,
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                time,
                style: AppTextStyles.caption.copyWith(
                  color: timeColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
