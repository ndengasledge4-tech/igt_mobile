import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class MessagesPreview extends StatelessWidget {
  final VoidCallback onSecretariatPressed;
  final VoidCallback onAcademiquePressed;

  const MessagesPreview({
    super.key,
    required this.onSecretariatPressed,
    required this.onAcademiquePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageCard(
          initials: 'S',
          sender: 'Secrétariat',
          message: 'Votre dossier est prêt',
          time: '10h30',
          unread: true,
          onPressed: onSecretariatPressed,
        ),
        MessageCard(
          initials: 'SA',
          sender: 'Service académique',
          message: 'Nouvelle information disponible',
          time: 'Hier',
          unread: false,
          onPressed: onAcademiquePressed,
        ),
      ],
    );
  }
}

class MessageCard extends StatelessWidget {
  final String initials;
  final String sender;
  final String message;
  final String time;
  final bool unread;
  final VoidCallback onPressed;

  const MessageCard({
    super.key,
    required this.initials,
    required this.sender,
    required this.message,
    required this.time,
    required this.unread,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.xs,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: AppColors.softBlue,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: AppDimensions.sm),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sender,
                      style: AppTextStyles.title.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.xs),

                    Text(
                      message,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),

                  if (unread) ...[
                    const SizedBox(height: AppDimensions.xs),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
