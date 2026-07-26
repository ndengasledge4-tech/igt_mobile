import 'package:flutter/material.dart';

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
        children: const [
          _Item(
            title: "Résultats",
            icon: Icons.bar_chart,
            color: Color(0xFFE8F5E9),
            iconColor: Colors.green,
          ),
          _Item(
            title: "Horaire",
            icon: Icons.calendar_today,
            color: Color(0xFFE3F2FD),
            iconColor: Colors.blue,
          ),
          _Item(
            title: "Documents",
            icon: Icons.description,
            color: Color(0xFFFFF3E0),
            iconColor: Colors.orange,
          ),
          _Item(
            title: "Actualités",
            icon: Icons.campaign,
            color: Color(0xFFF3E5F5),
            iconColor: Colors.purple,
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

  const _Item({
    required this.title,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
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
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}