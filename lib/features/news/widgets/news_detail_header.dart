import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class NewsDetailHeader extends StatelessWidget {
  const NewsDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/news_detail.jpg",
          width: double.infinity,
          height: 240,
          fit: BoxFit.cover,
        ),

        Positioned(
          top: 16,
          left: 16,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: AppColors.text,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}