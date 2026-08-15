import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

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
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            _buildItem(
              index: 0,
              icon: PhosphorIcons.house,
              activeIcon: PhosphorIconsFill.house,
              label: 'Accueil',
            ),
            _buildItem(
              index: 1,
              icon: PhosphorIcons.graduationCap,
              activeIcon: PhosphorIconsFill.graduationCap,
              label: 'Académie',
            ),
            _buildItem(
              index: 2,
              icon: PhosphorIcons.newspaper,
              activeIcon: PhosphorIconsFill.newspaper,
              label: 'Actualité',
            ),
            _buildItem(
              index: 3,
              icon: PhosphorIcons.chatCircle,
              activeIcon: PhosphorIconsFill.chatCircle,
              label: 'Messagerie',
              badge: 0,
            ),
            _buildItem(
              index: 4,
              icon: PhosphorIcons.user,
              activeIcon: PhosphorIconsFill.user,
              label: 'Mon espace',
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
    int badge = 0,
  }) {
    final bool selected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    selected ? activeIcon : icon,
                    size: 25,
                    color: selected
                        ? AppColors.primary
                        : const Color(0xFF8797A7),
                  ),
                  if (badge > 0)
                    Positioned(
                      top: -9,
                      right: -10,
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD95757),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          badge > 99 ? '99+' : '$badge',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                  selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected
                      ? AppColors.primary
                      : const Color(0xFF8797A7),
                ),
              ),

              const SizedBox(height: 5),

              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: selected ? 38 : 0,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}