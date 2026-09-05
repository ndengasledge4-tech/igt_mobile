import 'package:flutter/material.dart';

class NewsFilter extends StatelessWidget {
  const NewsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip(label: "Tous", selected: true),
          const SizedBox(width: 10),
          _chip(label: "Événements"),
          const SizedBox(width: 10),
          _chip(label: "Annonces"),
          const SizedBox(width: 10),
          _chip(label: "Conférences"),
        ],
      ),
    );
  }

  Widget _chip({required String label, bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF3B82F6) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
