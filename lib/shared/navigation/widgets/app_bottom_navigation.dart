import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 82,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildItem(
              index: 0,
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: "Accueil",
            ),
            _buildItem(
              index: 1,
              icon: Icons.school_outlined,
              activeIcon: Icons.school_rounded,
              label: "Académie",
            ),
            _buildItem(
              index: 2,
              icon: Icons.newspaper_outlined,
              activeIcon: Icons.newspaper_rounded,
              label: "Actualité",
            ),
            _buildItem(
              index: 3,
              icon: Icons.chat_bubble_outline_rounded,
              activeIcon: Icons.chat_bubble_rounded,
              label: "Messagerie",
            ),
            _buildItem(
              index: 4,
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: "Mon espace",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool selected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.only(top: 8, bottom: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 30,
                height: 3,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Icon(
                selected ? activeIcon : icon,
                size: 26,
                color: selected ? AppColors.primary : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? AppColors.primary : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
