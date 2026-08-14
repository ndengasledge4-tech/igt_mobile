import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/detail_top_bar.dart';

class EvenementDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const EvenementDetailPage({
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.lg,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _hero(),
                    Padding(
                      padding: const EdgeInsets.all(
                        AppDimensions.sm,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['content'] ??
                                item['excerpt'] ??
                                '',
                            style: AppTextStyles.body.copyWith(
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          if (item['program'] != null) ...[
                            const SizedBox(
                              height: AppDimensions.lg,
                            ),
                            Text(
                              'Programme de la journée',
                              style: AppTextStyles.label,
                            ),
                            const SizedBox(height: 12),
                            _program(),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hero() {
    return Container(
      width: double.infinity,
      color: AppColors.success.withAlpha(28),
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.sm,
        20,
        AppDimensions.sm,
        18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(140),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              'Événement',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w700,
              ),
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
          const SizedBox(height: 16),
          _meta(
            Icons.calendar_month_rounded,
            item['date'].toString(),
            AppColors.primary,
          ),
          if (item['time'] != null) ...[
            const SizedBox(height: 8),
            _meta(
              Icons.access_time_filled_rounded,
              item['time'].toString(),
              AppColors.text,
            ),
          ],
          if (item['location'] != null) ...[
            const SizedBox(height: 8),
            _meta(
              Icons.location_pin,
              item['location'].toString(),
              AppColors.error,
            ),
          ],
        ],
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
          size: 13,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _program() {
    final program =
    List<Map<String, dynamic>>.from(
      item['program'] as List,
    );

    return Column(
      children: [
        for (int index = 0;
        index < program.length;
        index++)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: index < program.length - 1
                  ? const Border(
                bottom: BorderSide(
                  color: AppColors.border,
                ),
              )
                  : null,
            ),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 48,
                  child: Text(
                    program[index]['time'].toString(),
                    style:
                    AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    program[index]['description']
                        .toString(),
                    style:
                    AppTextStyles.bodySmall.copyWith(
                      color: AppColors.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}