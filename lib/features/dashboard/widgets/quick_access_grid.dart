import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
        children: [
          _Item(
            title: "Résultats",
            icon: Icons.bar_chart_rounded,
            color: const Color(0xFFE8F5E9),
            iconColor: AppColors.success,
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.academic,
              );
            },
          ),
          _Item(
            title: "Horaire",
            icon: Icons.calendar_today_rounded,
            color: const Color(0xFFE3F2FD),
            iconColor: AppColors.primary,
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.academic,
              );
            },
          ),
          _Item(
            title: "Documents",
            icon: Icons.description_rounded,
            color: const Color(0xFFFFF3E0),
            iconColor: AppColors.warning,
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.documents,
              );
            },
          ),
          _Item(
            title: "Actualités",
            icon: Icons.campaign_rounded,
            color: const Color(0xFFF3E5F5),
            iconColor: Colors.purple,
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.news,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _Item({
    required this.title,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  title,
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}