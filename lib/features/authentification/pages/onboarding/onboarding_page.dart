import 'package:flutter/material.dart';

import '../../pages/login/connexion_page.dart';
import '../../widgets/onboarding/onboarding_bottom_button.dart';
import '../../widgets/onboarding/onboarding_content.dart';
import '../../widgets/onboarding/onboarding_header.dart';
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
      'title': 'Votre parcours académique,\nen toute simplicité.',
      'description':
          'Retrouvez vos cours, résultats et informations académiques '
          'directement depuis votre smartphone.',
      'background': const Color(0xFFEAF3FB),
    },
    {
      'image': 'assets/images/results.png',
      'title': 'Suivez vos résultats\nen un instant.',
      'description':
          'Consultez vos notes, votre emploi du temps et vos cours '
          'en quelques secondes.',
      'background': const Color(0xFFEAF7EA),
    },
    {
      'image': 'assets/images/news.png',
      'title': 'Restez informé de\nla vie de l’IGT.',
      'description':
          'Retrouvez toutes les actualités, annonces et événements '
          'importants au même endroit.',
      'background': const Color(0xFFFFF3DF),
    },
    {
      'image': 'assets/images/messaging.png',
      'title': 'Échangez facilement\navec l’IGT.',
      'description':
          'Contactez les différents services de l’établissement '
          'directement depuis l’application.',
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
            // HEADER
            OnboardingHeader(onSkip: _skip),

            // CONTENU
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

            // INDICATEUR
            OnboardingIndicator(
              currentIndex: _currentPage,
              count: _pages.length,
            ),

            const SizedBox(height: 24),

            // BOUTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
