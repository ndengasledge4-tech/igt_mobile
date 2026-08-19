import 'package:flutter/material.dart';

import '../../features/academic/academic_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/documents/documents_screen.dart';
import '../../features/news/news_screen.dart';
import '../../features/profile/profile_screen.dart';
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

  static const List<Widget> _pages = [
    DashboardScreen(),
    NewsScreen(),
    AcademicScreen(),
    DocumentsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
