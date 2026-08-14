import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class MessageComposer extends StatelessWidget {
  const MessageComposer({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onSend,
    this.enabled = true,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.md,
        AppDimensions.sm,
        AppDimensions.md,
        AppDimensions.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              enabled: enabled,
              controller: null,
              onChanged: onChanged,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.text,
              ),
              decoration: InputDecoration(
                hintText: 'Écrire un message...',
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.hint,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.md,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),

          const SizedBox(width: AppDimensions.sm),

          SizedBox.square(
            dimension: 40,
            child: IconButton(
              onPressed: enabled && value.trim().isNotEmpty
                  ? onSend
                  : null,
              icon: const Icon(
                Icons.send_rounded,
                size: AppDimensions.iconSmall,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.primaryLight,
                disabledForegroundColor: AppColors.white,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}