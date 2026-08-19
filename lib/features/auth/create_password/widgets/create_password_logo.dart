import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';

class CreatePasswordLogo extends StatelessWidget {
  const CreatePasswordLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppAssets.logo, width: 100, height: 100);
  }
}
