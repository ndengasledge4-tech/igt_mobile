import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import 'widgets/news_action_buttons.dart';
import 'widgets/news_badge.dart';
import 'widgets/news_description.dart';
import 'widgets/news_detail_header.dart';
import 'widgets/news_info_card.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            const NewsDetailHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        NewsBadge(),

                        Spacer(),

                        Text(
                          "28 Juillet 2025",
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Cérémonie de remise de diplômes\nPromotion 2025",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const NewsInfoCard(),

                    const SizedBox(height: 20),

                    const NewsDescription(),

                    const SizedBox(height: 30),

                    const NewsActionButtons(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}