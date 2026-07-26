import 'package:flutter/material.dart';

import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_summary_card.dart';
import 'widgets/quick_access_grid.dart';
import 'widgets/recent_news_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const DashboardHeader(),

            const DashboardSummaryCard(),

            Padding(
              padding: const EdgeInsets.only(top: 290),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Accès rapides",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  QuickAccessGrid(),

                  SizedBox(height: 30),

                  RecentNewsSection(),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}