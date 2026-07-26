import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class NotificationTitle extends StatelessWidget {
  final String title;

  const NotificationTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
    );
  }
}