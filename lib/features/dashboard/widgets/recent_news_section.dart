import 'package:flutter/material.dart';

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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Voir tout"),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const _NewsCard(
            color: Color(0xFFE8F5E9),
            icon: Icons.school,
            title: "Rentrée académique",
            subtitle: "Les cours débutent le 12 septembre.",
            date: "Aujourd'hui",
          ),

          SizedBox(height: 14),

          const _NewsCard(
            color: Color(0xFFE3F2FD),
            icon: Icons.event,
            title: "Conférence Flutter",
            subtitle: "Vendredi à 10h00 dans l'amphi A.",
            date: "Hier",
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;

  const _NewsCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Text(
            date,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}