import 'package:flutter/material.dart';

import '../../features/accueil/pages/accueil_page.dart';
import '../../features/actualite/pages/actualites_page.dart';
import '../../features/academie/pages/academie_page.dart';
import '../../features/mon_espace/pages/mon_espace_page.dart';
import '../../features/messagerie/pages/messagerie_page.dart';

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
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = const [
    AccueilPage(),
    AcademiePage(),
    ActualitePage(),
    MessageriePage(),
    MonEspacePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
