import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';

class NewsDetailHeader extends StatelessWidget {
  const NewsDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.newsPrimary,
      width: double.infinity,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}
