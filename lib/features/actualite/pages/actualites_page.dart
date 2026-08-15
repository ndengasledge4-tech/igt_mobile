import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme/colors.dart';
import '../data/actualite_data.dart';
import '../widgets/actualite_card.dart';
import 'actualite_detail_page.dart';
import 'evenement_detail_page.dart';

class ActualitePage extends StatelessWidget {
  final int initialIndex;

  const ActualitePage({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => _ActualiteHomePage(initialIndex: initialIndex),
        );
      },
    );
  }
}

class _ActualiteHomePage extends StatefulWidget {
  final int initialIndex;

  const _ActualiteHomePage({required this.initialIndex});

  @override
  State<_ActualiteHomePage> createState() => _ActualiteHomePageState();
}

class _ActualiteHomePageState extends State<_ActualiteHomePage> {
  late int _selectedIndex;

  static const List<_ActualiteTabInfo> _tabs = [
    _ActualiteTabInfo(
      label: 'Actualités',
      icon: Icons.article_outlined,
      iconColor: Color(0xFFE1DFF4),
    ),
    _ActualiteTabInfo(
      label: 'Annonces',
      icon: Icons.campaign_rounded,
      iconColor: Color(0xFFFF3D75),
    ),
    _ActualiteTabInfo(
      label: 'Événements',
      icon: Icons.event_note_outlined,
      iconColor: Color(0xFF1F425E),
    ),
    _ActualiteTabInfo(
      label: 'Infos',
      icon: Icons.info_rounded,
      iconColor: Color(0xFF9ED8FF),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, _tabs.length - 1).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: _ActualiteScaffold(initialIndex: _selectedIndex),
    );
  }
}

class _ActualiteScaffold extends StatefulWidget {
  final int initialIndex;

  const _ActualiteScaffold({required this.initialIndex});

  @override
  State<_ActualiteScaffold> createState() => _ActualiteScaffoldState();
}

class _ActualiteScaffoldState extends State<_ActualiteScaffold> {
  late int _selectedIndex;

  static const List<_ActualiteTabInfo> _tabs = _ActualiteHomePageState._tabs;

  List<ActualiteItem> get _items {
    switch (_selectedIndex) {
      case 0:
        return ActualiteData.actualites;
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

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, _tabs.length - 1).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.actualiteBackground,
      body: Column(
        children: [
          _ActualiteHeader(
            tabs: _tabs,
            selectedIndex: _selectedIndex,
            onTabSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    final items = _items;

    if (items.isEmpty) {
      return const Center(
        child: Text(
          'Aucun contenu disponible',
          style: TextStyle(
            color: AppColors.actualiteMutedText,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(8, _selectedIndex == 1 ? 14 : 9, 8, 26),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ActualiteCard(
          item: item,
          onTap: () => _openDetail(context, item),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 10),
    );
  }

  void _openDetail(BuildContext context, ActualiteItem item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) {
          if (item.category == ActualiteCategory.evenement) {
            return EvenementDetailPage(item: item);
          }

          return ActualiteDetailPage(item: item);
        },
      ),
    );
  }
}

class _ActualiteHeader extends StatelessWidget {
  final List<_ActualiteTabInfo> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const _ActualiteHeader({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Actualité',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                for (var index = 0; index < tabs.length; index++)
                  _ActualiteTabButton(
                    tab: tabs[index],
                    selected: selectedIndex == index,
                    onTap: () => onTabSelected(index),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActualiteTabButton extends StatelessWidget {
  final _ActualiteTabInfo tab;
  final bool selected;
  final VoidCallback onTap;

  const _ActualiteTabButton({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                tab.icon,
                color: selected ? tab.iconColor : tab.iconColor.withAlpha(210),
                size: 16,
              ),
              const SizedBox(height: 4),
              Text(
                tab.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white.withAlpha(205),
                  fontSize: 10.2,
                  height: 1,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: selected ? 46 : 0,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActualiteTabInfo {
  final String label;
  final IconData icon;
  final Color iconColor;

  const _ActualiteTabInfo({
    required this.label,
    required this.icon,
    required this.iconColor,
  });
}
