import 'package:flutter/material.dart';

import '../../app/theme/semantic_colors.dart';
import '../../shared/widgets/app_header.dart';
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
      appBar: const AppHeader.secondary(
        title: 'Détail de l’actualité',
        subtitle: 'Publication officielle de l’IGT',
      ),
      body: Column(
        children: [
          const NewsDetailHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const NewsBadge(),

                      Spacer(),

                      Text(
                        "28 Juillet 2025",
                        style: TextStyle(
                          color: context.semanticColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Cérémonie de remise de diplômes\nPromotion 2025",
                    style: Theme.of(context).textTheme.headlineMedium,
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
    );
  }
}
