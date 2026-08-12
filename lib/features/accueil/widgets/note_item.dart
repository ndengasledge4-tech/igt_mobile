import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  final String subject;
  final String note;
  final bool good;

  const NoteItem({
    super.key,
    required this.subject,
    required this.note,
    required this.good,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject,
            style: const TextStyle(fontSize: 9),
          ),
          Text(
            note,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: good
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
            ),
          ),
        ],
      ),
    );
  }
}