import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme/colors.dart';
import '../widgets/actualite_card.dart';

class ActualiteDetailPage extends StatelessWidget {
  final ActualiteItem item;

  const ActualiteDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.actualiteBackground,
        body: Column(
          children: [
            const _DetailTopBar(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    switch (item.category) {
      case ActualiteCategory.annonce:
        return _announcementDetail();
      case ActualiteCategory.info:
        return _infoDetail();
      case ActualiteCategory.actualite:
      case ActualiteCategory.evenement:
        return _newsDetail();
    }
  }

  Widget _newsDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _newsHero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 28, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._paragraphWidgets(item.content ?? item.excerpt),
                if (item.objective != null) ...[
                  const SizedBox(height: 5),
                  _objectiveCard(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _announcementDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _announcementHero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._paragraphWidgets(item.content ?? item.excerpt),
                if (item.alertTitle != null && item.alertText != null) ...[
                  const SizedBox(height: 15),
                  _alertCard(),
                ],
                if (item.documents != null && item.documents!.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  const Text('Documents requis', style: _sectionTitleStyle),
                  const SizedBox(height: 10),
                  for (final document in item.documents!)
                    _documentRow(document),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoHero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 22, 8, 0),
            child: Column(
              children: [
                if (item.infoRows != null)
                  _tableCard(title: 'Horaires habituels', rows: item.infoRows!),
                if (item.contacts != null) ...[
                  const SizedBox(height: 12),
                  _tableCard(
                    title: 'Contact direct',
                    rows: item.contacts!
                        .map(
                          (contact) => InfoRow(
                            label: contact.label,
                            value: contact.value,
                          ),
                        )
                        .toList(),
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

  Widget _newsHero() {
    return Container(
      width: double.infinity,
      color: AppColors.actualiteSoftBlue,
      padding: const EdgeInsets.fromLTRB(8, 19, 8, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Actualité', style: _blueLabelStyle),
          const SizedBox(height: 13),
          Text(item.detailTitle ?? item.title, style: _heroTitleStyle),
          const SizedBox(height: 12),
          Row(
            children: [
              _inlineMeta(
                Icons.calendar_month_rounded,
                item.detailDate ?? item.date,
                const Color(0xFF2E8EEA),
              ),
              const SizedBox(width: 13),
              if (item.subtitle != null)
                Flexible(
                  child: _inlineMeta(
                    Icons.edit_note_rounded,
                    item.subtitle!,
                    const Color(0xFFFF9B37),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _announcementHero() {
    return Container(
      width: double.infinity,
      color: AppColors.actualiteSoftRed,
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _softPill('Annonce'),
              if (item.badge != null) ...[
                const SizedBox(width: 10),
                Text(item.badge!, style: _importantLabelStyle),
              ],
            ],
          ),
          const SizedBox(height: 13),
          Text(item.detailTitle ?? item.title, style: _heroTitleStyle),
          const SizedBox(height: 13),
          Row(
            children: [
              _inlineMeta(
                Icons.calendar_month_rounded,
                item.detailDate ?? item.date,
                const Color(0xFF2E8EEA),
              ),
              const SizedBox(width: 13),
              if (item.subtitle != null)
                Flexible(
                  child: _inlineMeta(
                    Icons.school_outlined,
                    item.subtitle!,
                    const Color(0xFFD99045),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoHero() {
    return Container(
      width: double.infinity,
      color: AppColors.actualiteSoftBlue,
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 31),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.subtitle ?? 'Info pratique', style: _blueLabelStyle),
          const SizedBox(height: 19),
          Text(item.detailTitle ?? item.title, style: _heroTitleStyle),
          const SizedBox(height: 18),
          _inlineMeta(
            Icons.calendar_month_rounded,
            'En vigueur depuis le ${item.detailDate ?? item.date}',
            const Color(0xFF2E8EEA),
          ),
        ],
      ),
    );
  }

  Widget _objectiveCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.actualiteSoftBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🎯 Objectif', style: _objectiveTitleStyle),
          const SizedBox(height: 5),
          Text(item.objective!, style: _compactBodyStyle),
        ],
      ),
    );
  }

  Widget _alertCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.actualiteSoftYellow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.alertTitle!, style: _alertTitleStyle),
          const SizedBox(height: 6),
          Text(item.alertText!, style: _compactBodyStyle),
        ],
      ),
    );
  }

  Widget _tableCard({
    required String title,
    required List<InfoRow> rows,
    bool blueValues = false,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.actualiteCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 13, 12, 10),
            child: Text(title, style: _tableTitleStyle),
          ),
          for (var index = 0; index < rows.length; index++)
            _tableRow(
              rows[index],
              showTopBorder: index > 0,
              blueValue: blueValues,
            ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _tableRow(
    InfoRow row, {
    required bool showTopBorder,
    required bool blueValue,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: showTopBorder
            ? const Border(
                top: BorderSide(color: AppColors.actualiteCardBorder),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              row.label,
              style: _tableLabelStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              row.value,
              textAlign: TextAlign.right,
              style: _tableValueStyle.copyWith(
                color: blueValue
                    ? AppColors.actualiteHeader
                    : AppColors.actualiteText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Container(
            width: 13,
            height: 13,
            decoration: const BoxDecoration(
              color: Color(0xFFDDF7E8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Color(0xFF34B66C),
              size: 10,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: _compactBodyStyle)),
        ],
      ),
    );
  }

  List<Widget> _paragraphWidgets(String text) {
    final paragraphs = text.split('\n\n');

    return [
      for (var index = 0; index < paragraphs.length; index++) ...[
        _emphasizedText(paragraphs[index]),
        if (index < paragraphs.length - 1) const SizedBox(height: 14),
      ],
    ];
  }

  Widget _emphasizedText(String text) {
    return RichText(
      text: TextSpan(style: _bodyStyle, children: _spans(text)),
    );
  }

  List<TextSpan> _spans(String text) {
    if (item.emphasisPhrases.isEmpty) {
      return [TextSpan(text: text)];
    }

    final spans = <TextSpan>[];
    var cursor = 0;

    while (cursor < text.length) {
      var nextIndex = -1;
      String? nextPhrase;

      for (final phrase in item.emphasisPhrases.where(
        (phrase) => phrase.isNotEmpty,
      )) {
        final index = text.indexOf(phrase, cursor);
        if (index >= 0 && (nextIndex == -1 || index < nextIndex)) {
          nextIndex = index;
          nextPhrase = phrase;
        }
      }

      if (nextIndex == -1 || nextPhrase == null) {
        spans.add(TextSpan(text: text.substring(cursor)));
        break;
      }

      if (nextIndex > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, nextIndex)));
      }

      spans.add(
        TextSpan(
          text: nextPhrase,
          style: _bodyStyle.copyWith(fontWeight: FontWeight.w800),
        ),
      );
      cursor = nextIndex + nextPhrase.length;
    }

    return spans;
  }

  Widget _softPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.actualiteSoftBlue,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(text, style: _blueLabelStyle),
    );
  }

  Widget _inlineMeta(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 11),
        const SizedBox(width: 4),
        Text(
          text,
          style: _metaStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  static const TextStyle _heroTitleStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 19.4,
    height: 1.12,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _blueLabelStyle = TextStyle(
    color: AppColors.actualiteHeader,
    fontSize: 10.7,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _importantLabelStyle = TextStyle(
    color: AppColors.error,
    fontSize: 10.4,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _metaStyle = TextStyle(
    color: AppColors.actualiteMutedText,
    fontSize: 10.7,
    height: 1.1,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _bodyStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 13.4,
    height: 1.58,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle _compactBodyStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 11.8,
    height: 1.35,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle _objectiveTitleStyle = TextStyle(
    color: AppColors.actualiteHeader,
    fontSize: 11.8,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _alertTitleStyle = TextStyle(
    color: Color(0xFFE58B23),
    fontSize: 11.8,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _sectionTitleStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 14.2,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _tableTitleStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 12.8,
    height: 1,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle _tableLabelStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 11.4,
    height: 1,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _tableValueStyle = TextStyle(
    color: AppColors.actualiteText,
    fontSize: 11.4,
    height: 1,
    fontWeight: FontWeight.w800,
  );
}

class _DetailTopBar extends StatelessWidget {
  const _DetailTopBar();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Container(
      height: topInset + 45,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.actualiteCardBorder),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: topInset),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Material(
              color: AppColors.actualiteSoftBlue,
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
                    color: AppColors.actualiteHeader,
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
