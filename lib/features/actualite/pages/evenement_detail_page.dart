import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/actualite_card.dart';

class EvenementDetailPage extends StatelessWidget {
  final ActualiteItem item;

  const EvenementDetailPage({super.key, required this.item});

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
            const _EventTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: AppDimensions.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _hero(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppDimensions.sm,
                        18,
                        AppDimensions.sm,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.content ?? item.excerpt, style: _bodyStyle),
                          if (item.program != null &&
                              item.program!.isNotEmpty) ...[
                            const SizedBox(height: AppDimensions.lg),
                            Text(
                              'Programme de la journée',
                              style: _sectionTitleStyle,
                            ),
                            const SizedBox(height: 15),
                            _programTable(item.program!),
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
        19,
        AppDimensions.sm,
        17,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _eventLabel(),
          const SizedBox(height: 14),
          Text(item.detailTitle ?? item.title, style: _heroTitleStyle),
          const SizedBox(height: 16),
          _eventMetaRow(
            Icons.calendar_month_rounded,
            item.detailDate ?? item.date,
            AppColors.primary,
          ),
          const SizedBox(height: AppDimensions.sm),
          if (item.time != null)
            _eventMetaRow(
              Icons.access_time_filled_rounded,
              item.time!,
              AppColors.text,
            ),
          if (item.subtitle != null) ...[
            const SizedBox(height: AppDimensions.sm),
            _eventMetaRow(
              Icons.location_pin,
              item.subtitle!,
              AppColors.error,
            ),
          ],
        ],
      ),
    );
  }

  Widget _eventLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(120),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text('Événement', style: _eventLabelStyle),
    );
  }

  Widget _eventMetaRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 12),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: _metaStrongStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _programTable(List<ProgramStep> steps) {
    return Column(
      children: [
        for (var index = 0; index < steps.length; index++)
          _programRow(steps[index], showBottomBorder: index < steps.length - 1),
      ],
    );
  }

  Widget _programRow(ProgramStep step, {required bool showBottomBorder}) {
    return Container(
      decoration: BoxDecoration(
        border: showBottomBorder
            ? const Border(
                bottom: BorderSide(color: AppColors.border),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 48, child: Text(step.time, style: _programTimeStyle)),
          const SizedBox(width: 5),
          Expanded(
            child: Text(step.description, style: _programDescriptionStyle),
          ),
        ],
      ),
    );
  }

  static final TextStyle _heroTitleStyle = AppTextStyles.headline3.copyWith(
    color: AppColors.text,
    fontSize: 19.4,
    height: 1.12,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle _eventLabelStyle = AppTextStyles.caption.copyWith(
    color: AppColors.success,
    fontSize: 10.7,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle _metaStrongStyle = AppTextStyles.caption.copyWith(
    color: AppColors.text,
    fontSize: 11.6,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle _bodyStyle = AppTextStyles.bodySmall.copyWith(
    color: AppColors.text,
    fontSize: 13.4,
    height: 1.58,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _sectionTitleStyle = AppTextStyles.label.copyWith(
    color: AppColors.text,
    fontSize: 14.2,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle _programTimeStyle = AppTextStyles.caption.copyWith(
    color: AppColors.primary,
    fontSize: 11.7,
    height: 1.1,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle _programDescriptionStyle =
      AppTextStyles.caption.copyWith(
        color: AppColors.text,
        fontSize: 11.7,
        height: 1.1,
        fontWeight: FontWeight.w500,
      );
}

class _EventTopBar extends StatelessWidget {
  const _EventTopBar();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Container(
      height: topInset + 45,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: topInset),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: AppDimensions.xs),
            child: Material(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(7),
              child: InkWell(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                borderRadius: BorderRadius.circular(7),
                child: const SizedBox(
                  width: 28,
                  height: 28,
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
