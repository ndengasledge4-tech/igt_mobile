import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ActualiteCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onTap;

  const ActualiteCard({super.key, required this.item, this.onTap});

  bool get _isEvent => item['category'] == 'evenement';

  bool get _hasNotice => item['topNotice'] != null;

  double get _height {
    if (_hasNotice) {
      return 138;
    }

    if (item['category'] == 'info') {
      return 96;
    }

    return 110;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Ink(
          height: _height,
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            border: Border.all(color: AppColors.border),
          ),
          child: _hasNotice
              ? Column(
                  children: [
                    _notice(),
                    const SizedBox(height: 10),
                    Expanded(child: _content()),
                  ],
                )
              : _content(),
        ),
      ),
    );
  }

  Widget _content() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: _hasNotice ? 0 : 9),
          child: _icon(),
        ),
        const SizedBox(width: 11),
        Expanded(child: _textContent()),
        const SizedBox(width: 3),
        const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.hint,
          size: AppDimensions.iconSmall,
        ),
      ],
    );
  }

  Widget _icon() {
    final Color background =
        item['iconBackground'] as Color? ?? AppColors.primary;

    final IconData icon = item['icon'] as IconData? ?? Icons.article_outlined;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: background.withAlpha(28),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: _categoryColor, size: 22),
    );
  }

  Widget _textContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _meta(),
        if (_isEvent && item['location'] != null) ...[
          const SizedBox(height: 2),
          Text(
            item['location'].toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _metaStyle,
          ),
        ],
        const SizedBox(height: 4),
        Text(
          item['title'].toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: _titleStyle,
        ),
        const SizedBox(height: 5),
        Text(
          item['excerpt'].toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: _excerptStyle,
        ),
      ],
    );
  }

  Widget _meta() {
    String text = item['date'].toString();

    if (_isEvent && item['time'] != null) {
      text = '$text · ${item['time']}';
    }

    return Row(
      children: [
        const Icon(
          Icons.calendar_month_rounded,
          color: AppColors.primary,
          size: 12,
        ),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _metaStyle,
          ),
        ),
        if (_isEvent) ...[
          const SizedBox(width: 5),
          const Icon(Icons.location_pin, color: AppColors.error, size: 10),
        ],
      ],
    );
  }

  Widget _notice() {
    return Container(
      width: double.infinity,
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.error.withAlpha(24),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(item['topNotice'].toString(), style: _noticeStyle),
    );
  }

  Color get _categoryColor {
    switch (item['category']) {
      case 'annonce':
        return AppColors.error;

      case 'evenement':
        return AppColors.success;

      case 'info':
        return AppColors.primaryDark;

      default:
        return AppColors.primary;
    }
  }

  static final TextStyle _metaStyle = AppTextStyles.caption.copyWith(
    color: AppColors.secondaryText,
    fontSize: 10.4,
    height: 1.15,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _titleStyle = AppTextStyles.label.copyWith(
    color: AppColors.text,
    fontSize: 12.8,
    height: 1.16,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle _excerptStyle = AppTextStyles.bodySmall.copyWith(
    color: AppColors.secondaryText,
    fontSize: 11.2,
    height: 1.18,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _noticeStyle = AppTextStyles.caption.copyWith(
    color: AppColors.error,
    fontSize: 10.5,
    height: 1,
    fontWeight: FontWeight.w700,
  );
}
