import 'package:flutter/material.dart';

<<<<<<< HEAD
import '../../features/academic/academic_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/documents/documents_screen.dart';
import '../../features/news/news_screen.dart';
import '../../features/profile/profile_screen.dart';
=======
import '../../features/accueil/pages/accueil_page.dart';
import '../../features/actualite/pages/actualites_page.dart';
import '../../features/academie/pages/academie_page.dart';
import '../../features/mon_espace/pages/mon_espace_page.dart';
import '../../features/messagerie/pages/messagerie_page.dart';

>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
=======
      body: IndexedStack(
        index: _currentIndex,
        children: [
          AccueilPage(
            onNavigate: _navigateFromAccueil,
          ),
          const AcademiePage(),
          const ActualitePage(),
          const MessageriePage(),
          const MonEspacePage(),
        ],
      ),

      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
        },
      ),
    );
  }
<<<<<<< HEAD
}
=======

  void _navigateFromAccueil(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
