import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: const [
          _InfoRow(
            title: "Filière",
            value: "Génie Informatique",
          ),
          Divider(height: 1),

          _InfoRow(
            title: "Niveau",
            value: "3ème Année",
          ),
          Divider(height: 1),

          _InfoRow(
            title: "Campus",
            value: "Campus Principal, Tunis",
          ),
          Divider(height: 1),

          _InfoRow(
            title: "Numéro étudiant",
            value: "IGT2024-0187",
          ),
          Divider(height: 1),

          _InfoRow(
            title: "Email institutionnel",
            value: "a.bensalem@etu.igt.tn",
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}