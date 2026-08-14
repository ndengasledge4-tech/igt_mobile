import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/detail_top_bar.dart';

class ActualiteDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const ActualiteDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const DetailTopBar(),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (item['category']) {
      case 'annonce':
        return _announcement();

      case 'info':
        return _info();

      default:
        return _news();
    }
  }

  Widget _news() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hero(
            color: AppColors.softBlue,
            label: 'Actualité',
          ),
          _content(),
        ],
      ),
    );
  }

  Widget _announcement() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _announcementHero(),
          _content(),
          if (item['alertTitle'] != null)
            _alertCard(),
          if (item['documents'] != null)
            _documents(),
        ],
      ),
    );
  }

  Widget _info() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hero(
            color: AppColors.softBlue,
            label: item['subtitle'] ?? 'Info pratique',
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppDimensions.sm,
            ),
            child: Column(
              children: [
                if (item['infoRows'] != null)
                  _table(
                    'Horaires habituels',
                    item['infoRows'],
                  ),
                if (item['contacts'] != null) ...[
                  const SizedBox(height: AppDimensions.sm),
                  _table(
                    'Contact direct',
                    item['contacts'],
                    blueValues: true,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero({
    required Color color,
    required String label,
  }) {
    return Container(
      width: double.infinity,
      color: color,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.sm,
        20,
        AppDimensions.sm,
        28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item['detailTitle'] ?? item['title'],
            style: AppTextStyles.headline3.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          _meta(
            Icons.calendar_month_rounded,
            item['detailDate'] ?? item['date'],
            AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _announcementHero() {
    return Container(
      width: double.infinity,
      color: AppColors.error.withAlpha(24),
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.sm,
        20,
        AppDimensions.sm,
        18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _pill('Annonce'),
              if (item['badge'] != null) ...[
                const SizedBox(width: 10),
                Text(
                  item['badge'].toString(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Text(
            item['detailTitle'] ?? item['title'],
            style: AppTextStyles.headline3.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          _meta(
            Icons.calendar_month_rounded,
            item['detailDate'] ?? item['date'],
            AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _content() {
    final content =
        item['content'] ?? item['excerpt'] ?? '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.sm,
        20,
        AppDimensions.sm,
        0,
      ),
      child: Text(
        content.toString(),
        style: AppTextStyles.body.copyWith(
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _meta(
      IconData icon,
      String text,
      Color color,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 12,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _alertCard() {
    return Padding(
      padding: const EdgeInsets.all(
        AppDimensions.sm,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.warning.withAlpha(28),
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusSmall,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['alertTitle'].toString(),
              style: AppTextStyles.label.copyWith(
                color: AppColors.warning,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item['alertText'].toString(),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _documents() {
    final documents =
    List<String>.from(item['documents'] as List);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.sm,
        4,
        AppDimensions.sm,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documents requis',
            style: AppTextStyles.label,
          ),
          const SizedBox(height: 10),
          for (final document in documents)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 7,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 15,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      document,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _table(
      String title,
      List<dynamic> rows, {
        bool blueValues = false,
      }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusSmall,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: AppTextStyles.label.copyWith(
                fontSize: 13,
              ),
            ),
          ),
          for (int index = 0; index < rows.length; index++)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: index > 0
                    ? const Border(
                  top: BorderSide(
                    color: AppColors.border,
                  ),
                )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      rows[index]['label'].toString(),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      rows[index]['value'].toString(),
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption.copyWith(
                        color: blueValues
                            ? AppColors.primary
                            : AppColors.text,
                        fontWeight: FontWeight.w700,
                      ),
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