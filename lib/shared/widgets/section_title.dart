import 'package:flutter/material.dart';

import 'app_section_header.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionTitle({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return AppSectionHeader(title: title, onAction: onSeeAll);
  }
}
