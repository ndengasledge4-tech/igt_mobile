import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class MessageriePage extends StatelessWidget {
  const MessageriePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("MessageriePage"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text("Page Messagerie", style: AppTextStyles.title),
      ),
    );
  }
}
