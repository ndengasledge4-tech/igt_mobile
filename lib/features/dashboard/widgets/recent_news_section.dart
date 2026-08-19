import 'package:flutter/material.dart';

import '../../../app/theme/text_styles.dart';
import '../../../core/constants/assets.dart';
import '../../../shared/navigation/navigation_page.dart';
import 'recent_news_card.dart';

class RecentNewsSection extends StatelessWidget {
  const RecentNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Actualités récentes",
                  style: AppTextStyles.headline3,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NavigationPage(initialIndex: 1),
                    ),
                  );
                },
                child: const Text("Voir tout"),
              ),
            ],
          ),

          const SizedBox(height: 18),

          RecentNewsCard(
            image: AppAssets.newsPrimary,
            tag: "Annonce",
            tagColor: Colors.orange,
            title: "Calendrier des examens du semestre 2 — Session principale",
            description:
                "Le calendrier officiel des examens est désormais disponible.",
            likes: 92,
            comments: 12,
            date: "15 Juillet",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const NavigationPage(initialIndex: 1),
                ),
              );
            },
          ),

          const SizedBox(height: 18),

          RecentNewsCard(
            image: AppAssets.newsSecondary,
            tag: "Conférence",
            tagColor: Colors.deepPurple,
            title:
                "Conférence internationale : Innovation et Intelligence Artificielle",
            description:
                "Participez à une conférence exceptionnelle réunissant des experts.",
            likes: 76,
            comments: 8,
            date: "10 Juillet",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const NavigationPage(initialIndex: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
