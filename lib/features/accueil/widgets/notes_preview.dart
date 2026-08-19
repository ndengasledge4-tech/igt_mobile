import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class NotesPreview extends StatelessWidget {
  const NotesPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(color: AppColors.border),
        ),
        child: const Column(
          children: [
            NoteRow(subject: 'Algorithmique', note: '16.5 / 20', isGood: true),
            Divider(),
            NoteRow(
              subject: 'Bases de données',
              note: '12 / 20',
              isGood: false,
            ),
            Divider(),
            NoteRow(subject: 'Réseaux', note: '18 / 20', isGood: true),
          ],
        ),
      ),
    );
  }
}

class NoteRow extends StatelessWidget {
  final String subject;
  final String note;
  final bool isGood;

  const NoteRow({
    super.key,
    required this.subject,
    required this.note,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            note,
            style: AppTextStyles.bodySmall.copyWith(
              color: isGood ? AppColors.success : AppColors.warning,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
