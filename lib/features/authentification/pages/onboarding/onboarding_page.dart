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

  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/images/academic.png',
      'title': 'Votre vie académique,\nsimplement.',
      'description':
      'Accédez à tout votre parcours universitaire\ndepuis votre smartphone, à tout moment.',
      'background': const Color(0xFFEAF3FB),
    },
    {
      'image': 'assets/images/results.png',
      'title': 'Retrouvez votre parcours\net vos résultats.',
      'description':
      'Consultez vos notes, résultats, emploi du\ntemps et cours en quelques secondes.',
      'background': const Color(0xFFEAF7EA),
    },
    {
      'image': 'assets/images/news.png',
      'title': 'Restez informé des\nactualités de l’IGT.',
      'description':
      'Ne manquez plus aucune annonce,\névénement ou communication importante.',
      'background': const Color(0xFFFFF3DF),
    },
    {
      'image': 'assets/images/messaging.png',
      'title': 'Échangez facilement avec\nles services de l’IGT.',
      'description':
      'Contactez le secrétariat, le service académique\nou la direction directement depuis l’app.',
      'background': const Color(0xFFFCE8F0),
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
        curve: Curves.easeOutCubic,
      );
    } else {
      _goToLogin();
    }
  }

  void _skip() {
    _goToLogin();
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ConnexionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ============================================
            // PASSER
            // ============================================
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  top: 4,
                ),
                child: TextButton(
                  onPressed: _skip,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
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
            ),

            // ============================================
            // CONTENU
            // ============================================
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
                    image: page['image'] as String,
                    title: page['title'] as String,
                    description: page['description'] as String,
                    backgroundColor: page['background'] as Color,
                  );
                },
              ),
            ),

            // ============================================
            // INDICATEURS
            // ============================================
            OnboardingIndicator(
              currentIndex: _currentPage,
              count: _pages.length,
            ),

            const SizedBox(height: 28),

            // ============================================
            // BOUTON FIXE
            // ============================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: OnboardingBottomButton(
                label: _currentPage == _pages.length - 1
                    ? 'Commencer'
                    : 'Suivant',
                onPressed: _nextPage,
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}