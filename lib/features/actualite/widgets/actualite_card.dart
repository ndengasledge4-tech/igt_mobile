import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

enum ActualiteCategory { actualite, annonce, evenement, info }

class ActualiteItem {
  final String title;
  final String? detailTitle;
  final String date;
  final String excerpt;
  final String? content;
  final ActualiteCategory category;
  final IconData icon;
  final Color iconBackground;
  final String? emoji;
  final String? subtitle;
  final String? badge;
  final String? detailDate;
  final String? time;
  final String? location;
  final String? topNotice;
  final String? objective;
  final String? alertTitle;
  final String? alertText;
  final List<String> emphasisPhrases;
  final List<String>? documents;
  final List<ProgramStep>? program;
  final List<InfoRow>? infoRows;
  final List<ContactInfo>? contacts;

  const ActualiteItem({
    required this.title,
    this.detailTitle,
    required this.date,
    required this.excerpt,
    required this.category,
    required this.icon,
    required this.iconBackground,
    this.content,
    this.emoji,
    this.subtitle,
    this.badge,
    this.detailDate,
    this.time,
    this.location,
    this.topNotice,
    this.objective,
    this.alertTitle,
    this.alertText,
    this.emphasisPhrases = const [],
    this.documents,
    this.program,
    this.infoRows,
    this.contacts,
  });
}

class ProgramStep {
  final String time;
  final String description;

  const ProgramStep({required this.time, required this.description});
}

class InfoRow {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value});
}

class ContactInfo {
  final IconData icon;
  final String label;
  final String value;

  const ContactInfo({
    required this.icon,
    required this.label,
    required this.value,
  });
}

String actualiteCategoryLabel(ActualiteCategory category) {
  switch (category) {
    case ActualiteCategory.actualite:
      return 'Actualité';
    case ActualiteCategory.annonce:
      return 'Annonce';
    case ActualiteCategory.evenement:
      return 'Événement';
    case ActualiteCategory.info:
      return 'Info';
  }
}

Color actualiteCategoryColor(ActualiteCategory category) {
  switch (category) {
    case ActualiteCategory.actualite:
      return AppColors.actualiteHeader;
    case ActualiteCategory.annonce:
      return AppColors.error;
    case ActualiteCategory.evenement:
      return AppColors.success;
    case ActualiteCategory.info:
      return AppColors.primaryDark;
  }
}

class ActualiteCard extends StatelessWidget {
  final ActualiteItem item;
  final VoidCallback? onTap;

  const ActualiteCard({super.key, required this.item, this.onTap});

  double get _cardHeight {
    if (item.topNotice != null) {
      return 138;
    }

    switch (item.category) {
      case ActualiteCategory.info:
        return 96;
      case ActualiteCategory.actualite:
      case ActualiteCategory.annonce:
      case ActualiteCategory.evenement:
        return 110;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: _cardHeight,
          padding: const EdgeInsets.fromLTRB(12, 10, 7, 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.actualiteCardBorder),
            boxShadow: const [
              BoxShadow(
                color: Color(0x07000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: item.topNotice == null
              ? _contentRow()
              : Column(
                  children: [
                    _noticeBanner(),
                    const SizedBox(height: 10),
                    Expanded(child: _contentRow()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _contentRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: item.topNotice == null ? 10 : 0),
          child: _leadingIcon(),
        ),
        const SizedBox(width: 11),
        Expanded(child: _textContent()),
        const SizedBox(width: 3),
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF86A0BA),
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _textContent() {
    final bool isEvent = item.category == ActualiteCategory.evenement;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _metaRow(isEvent),
        if (isEvent && item.location != null) ...[
          const SizedBox(height: 2),
          Text(
            item.location!,
            style: _metaStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 4),
        Text(
          item.title,
          style: _titleStyle,
          maxLines: isEvent ? 2 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Text(
          item.excerpt,
          style: _excerptStyle,
          maxLines: isEvent ? 2 : 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _metaRow(bool isEvent) {
    final text = isEvent && item.time != null
        ? '${item.date} · ${item.time}'
        : item.date;

    return Row(
      children: [
        const Icon(
          Icons.calendar_month_rounded,
          color: Color(0xFF2E8EEA),
          size: 10,
        ),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            text,
            style: _metaStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isEvent) ...[
          const SizedBox(width: 5),
          const Icon(Icons.location_pin, color: Color(0xFFE0416F), size: 10),
        ],
      ],
    );
  }

  Widget _leadingIcon() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: item.iconBackground.withAlpha(26),
        borderRadius: BorderRadius.circular(9),
      ),
      alignment: Alignment.center,
      child: item.emoji != null
          ? Text(item.emoji!, style: const TextStyle(fontSize: 22, height: 1))
          : Icon(
              item.icon,
              color: actualiteCategoryColor(item.category),
              size: 22,
            ),
    );
  }

  Widget _noticeBanner() {
    return Container(
      width: double.infinity,
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: AppColors.actualiteSoftRed,
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        item.topNotice!,
        style: const TextStyle(
          color: AppColors.error,
          fontSize: 10.5,
          height: 1,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  static const TextStyle _metaStyle = TextStyle(
    color: AppColors.actualiteMutedText,
    fontSize: 10.4,
    height: 1.15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _titleStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 12.8,
    height: 1.16,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _excerptStyle = TextStyle(
    color: AppColors.actualiteMutedText,
    fontSize: 11.2,
    height: 1.18,
    fontWeight: FontWeight.w500,
  );
}
