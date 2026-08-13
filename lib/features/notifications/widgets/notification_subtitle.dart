import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class NotificationSubtitle extends StatelessWidget {
  final String subtitle;

  const NotificationSubtitle({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 13,
        height: 1.4,
        color: AppColors.secondaryText,
      ),
    );
  }
}
