import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';

class ActivationLogo extends StatelessWidget {
  const ActivationLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(AppAssets.logo, width: 110, height: 110));
  }
}
