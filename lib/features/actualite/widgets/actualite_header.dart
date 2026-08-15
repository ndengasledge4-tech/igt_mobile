import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ActualiteHeader extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const ActualiteHeader({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  static const List<_TabInfo> _tabs = [
    _TabInfo(
      label: 'Actualités',
      icon: Icons.article_outlined,
      color: AppColors.white,
    ),
    _TabInfo(
      label: 'Annonces',
      icon: Icons.campaign_rounded,
      color: AppColors.error,
    ),
    _TabInfo(
      label: 'Événements',
      icon: Icons.event_note_outlined,
      color: AppColors.primaryDark,
    ),
    _TabInfo(
      label: 'Infos',
      icon: Icons.info_rounded,
      color: AppColors.primaryLight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.only(top: topInset + 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm),
            child: Text(
              'Actualité',
              style: AppTextStyles.headline2.copyWith(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                for (int index = 0; index < _tabs.length; index++)
                  Expanded(
                    child: _TabButton(
                      tab: _tabs[index],
                      selected: selectedIndex == index,
                      onTap: () => onTabSelected(index),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final _TabInfo tab;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              tab.icon,
              color: selected ? tab.color : tab.color.withAlpha(200),
              size: 17,
            ),
            const SizedBox(height: AppDimensions.xs),
            Text(
              tab.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: selected
                    ? AppColors.white
                    : AppColors.white.withAlpha(200),
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.sm),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: selected ? 46 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabInfo {
  final String label;
  final IconData icon;
  final Color color;

  const _TabInfo({
    required this.label,
    required this.icon,
    required this.color,
  });
}
