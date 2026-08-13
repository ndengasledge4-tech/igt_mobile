import 'package:flutter/material.dart';

import '../../../app/theme/text_styles.dart';

class NotificationTime extends StatelessWidget {
  final String time;

  const NotificationTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Text(time, style: AppTextStyles.caption);
  }
}
