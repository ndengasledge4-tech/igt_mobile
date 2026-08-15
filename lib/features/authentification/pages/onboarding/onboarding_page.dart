import 'package:flutter/material.dart';

import '../../pages/login/connexion_page.dart';
import '../../widgets/onboarding/onboarding_bottom_button.dart';
import '../../widgets/onboarding/onboarding_content.dart';
import '../../widgets/onboarding/onboarding_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'icon': '🎓',
      'title': 'Votre vie académique,\nsimplement.',
      'description':
          'Accédez à tout votre parcours universitaire\ndepuis votre smartphone, à tout moment.',
      'background': '0xFFEAF3FB',
    },
    {
      'icon': '📊',
      'title': 'Retrouvez votre parcours\net vos résultats.',
      'description':
          'Consultez vos notes, résultats, emploi du\ntemps et cours en quelques secondes.',
      'background': '0xFFEAF7EA',
    },
    {
      'icon': '📰',
      'title': 'Restez informé des\nactualités de l’IGT.',
      'description':
          'Ne manquez plus aucune annonce,\névénement ou communication importante.',
      'background': '0xFFFFF3DF',
    },
    {
      'icon': '💬',
      'title': 'Échangez facilement avec\nles services de l’IGT.',
      'description':
          'Contactez le secrétariat, le service académique\nou la direction directement depuis l’app.',
      'background': '0xFFFCE8F0',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConnexionPage()),
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ConnexionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _skip,
                child: const Text(
                  'Passer',
                  style: TextStyle(
                    color: Color(0xFF8492A0),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];

                  return OnboardingContent(
                    icon: page['icon']!,
                    title: page['title']!,
                    description: page['description']!,
                    backgroundColor: Color(int.parse(page['background']!)),
                  );
                },
              ),
            ),

            OnboardingIndicator(
              currentIndex: _currentPage,
              count: _pages.length,
            ),

            const SizedBox(height: 28),

            OnboardingBottomButton(
              label: _currentPage == _pages.length - 1
                  ? 'Commencer'
                  : 'Suivant',
              onPressed: _nextPage,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
