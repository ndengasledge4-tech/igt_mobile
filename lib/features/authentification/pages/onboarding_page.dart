import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<_OnboardingItem> _items = const [
    _OnboardingItem(
      image: 'assets/images/onboarding_1.png',
      title: 'Votre espace étudiant',
      description:
      'Accédez facilement à toutes les informations liées à votre parcours universitaire.',
    ),
    _OnboardingItem(
      image: 'assets/images/onboarding_2.png',
      title: 'Suivez votre parcours',
      description:
      'Consultez vos cours, vos notes, vos résultats et votre emploi du temps depuis une seule application.',
    ),
    _OnboardingItem(
      image: 'assets/images/onboarding_3.png',
      title: 'Restez informé',
      description:
      'Recevez les actualités et les informations importantes de votre établissement.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        RouteNames.connexion,
      );
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(
      context,
      RouteNames.connexion,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // -------------------------------------------------
            // BOUTON PASSER
            // -------------------------------------------------
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  right: 20,
                ),
                child: TextButton(
                  onPressed: _skip,
                  child: const Text(
                    'Passer',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // -------------------------------------------------
            // CONTENU
            // -------------------------------------------------
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _items[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IMAGE
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                              errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                  ) {
                                return Container(
                                  width: 250,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: AppColors.softBlue,
                                    borderRadius:
                                    BorderRadius.circular(30),
                                  ),
                                  child: const Icon(
                                    Icons.school_rounded,
                                    size: 90,
                                    color: AppColors.primary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // TITRE
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.headline2,
                        ),

                        const SizedBox(height: 14),

                        // DESCRIPTION
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(
                            height: 1.6,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                },
              ),
            ),

            // -------------------------------------------------
            // INDICATEURS
            // -------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                    (index) {
                  final selected = index == _currentPage;

                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: selected ? 26 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.primaryLight,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // -------------------------------------------------
            // BOUTON
            // -------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                0,
                24,
                24,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    _currentPage == _items.length - 1
                        ? 'Commencer'
                        : 'Suivant',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// MODÈLE INTERNE UNIQUEMENT POUR L'AFFICHAGE DE L'ONBOARDING
// =============================================================

class _OnboardingItem {
  final String image;
  final String title;
  final String description;

  const _OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}