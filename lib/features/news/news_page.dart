import 'package:flutter/material.dart';

import 'widgets/news_header.dart';
import 'widgets/news_filter.dart';
import 'widgets/news_card.dart';
import 'widgets/announcement_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            NewsHeader(),

            SizedBox(height: 20),

            NewsFilter(),

            SizedBox(height: 20),

            NewsCard(),

            SizedBox(height: 16),

            AnnouncementCard(),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
