import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.pushNamed(context, RouteNames.newsDetail);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Image.network(
                "https://picsum.photos/600/300",
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Événement",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Cérémonie de remise de diplômes — Promotion 2025",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "La grande cérémonie de remise des diplômes de la promotion 2025 aura lieu à l'Amphithéâtre principal de l'IGT.",
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: const [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "28 Juillet 2025",
                        style: TextStyle(color: AppColors.secondaryText),
                      ),
                      SizedBox(width: 18),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "10h00",
                        style: TextStyle(color: AppColors.secondaryText),
                      ),
                    ],
                  ),

                  const Divider(height: 30),

                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(width: 5),
                      const Text("148"),

                      const SizedBox(width: 20),

                      const Icon(
                        Icons.mode_comment_outlined,
                        size: 18,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(width: 5),
                      const Text("34"),

                      const Spacer(),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.newsDetail);
                        },
                        child: const Text("Lire la suite →"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
