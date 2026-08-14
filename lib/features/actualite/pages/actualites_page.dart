import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import '../data/actualite_data.dart';
import '../widgets/actualite_card.dart';
import '../widgets/actualite_header.dart';
import 'actualite_detail_page.dart';
import 'evenement_detail_page.dart';

class ActualitePage extends StatefulWidget {
  final int initialIndex;

  const ActualitePage({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<ActualitePage> createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex.clamp(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            ActualiteHeader(
              selectedIndex: _selectedIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _items {
    switch (_selectedIndex) {
      case 1:
        return ActualiteData.annonces;

      case 2:
        return ActualiteData.evenements;

      case 3:
        return ActualiteData.infos;

      default:
        return ActualiteData.actualites;
    }
  }

  Widget _buildList() {
    final items = _items;

    if (items.isEmpty) {
      return Center(
        child: Text(
          'Aucun contenu disponible',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.sm,
        10,
        AppDimensions.sm,
        AppDimensions.lg,
      ),
      itemCount: items.length,
      separatorBuilder: (_, _) =>
      const SizedBox(height: AppDimensions.sm),
      itemBuilder: (context, index) {
        final item = items[index];

        return ActualiteCard(
          item: item,
          onTap: () => _openDetail(
            context,
            item,
          ),
        );
      },
    );
  }

  void _openDetail(
      BuildContext context,
      Map<String, dynamic> item,
      ) {
    if (item['category'] == 'evenement') {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => EvenementDetailPage(
            item: item,
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ActualiteDetailPage(
          item: item,
        ),
      ),
    );
  }
}