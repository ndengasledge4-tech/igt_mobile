import 'package:flutter/material.dart';

import '../../features/academie/pages/academie_page.dart';
import '../../features/academie/pages/MesDocuments/mes_documents_page.dart';
import '../../features/accueil/pages/accueil_page.dart';
import '../../features/actualite/pages/actualites_page.dart';
import '../../features/mon_espace/pages/mon_espace_page.dart';
import 'widgets/app_bottom_navigation.dart';

class NavigationPage extends StatefulWidget {
  final int initialIndex;

  const NavigationPage({super.key, this.initialIndex = 0});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 4);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      AccueilPage(onNavigate: _selectDestination),
      const ActualitePage(),
      const AcademiePage(),
      const MesDocumentsPage(embedded: true),
      const MonEspacePage(),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 1000;
        final content = IndexedStack(index: _currentIndex, children: pages);
        return Scaffold(
          body: useRail
              ? Row(
                  children: [
                    AppNavigationRail(
                      currentIndex: _currentIndex,
                      onDestinationSelected: _selectDestination,
                      extended: constraints.maxWidth >= 1280,
                    ),
                    Expanded(child: content),
                  ],
                )
              : content,
          bottomNavigationBar: useRail
              ? null
              : AppBottomNavigation(
                  currentIndex: _currentIndex,
                  onDestinationSelected: _selectDestination,
                ),
        );
      },
    );
  }

  void _selectDestination(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }
}
