import 'package:flutter/material.dart';

import 'app_section_header.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionTitle({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return AppSectionHeader(title: title, onAction: onSeeAll);
=======
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.headline3),
        if (onSeeAll != null)
          TextButton(onPressed: onSeeAll, child: const Text("Voir tout")),
      ],
    );
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
  }
}
