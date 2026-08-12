import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';

class NewsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String category;
  final String date;
  final VoidCallback onTap;

  const NewsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.category,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                icon,
                size: 18,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 7,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 7,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}