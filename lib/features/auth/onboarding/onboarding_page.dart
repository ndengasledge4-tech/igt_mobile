import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import 'widgets/onboarding_button.dart';
import 'widgets/onboarding_indicator.dart';
import 'widgets/onboarding_skip_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final pages = [
    (
      image: "assets/images/onboarding_1.png",
      title: "Votre vie académique,\nau même endroit",
      subtitle:
          "Accédez facilement aux informations essentielles de votre parcours académique.",
    ),
    (
      image: "assets/images/onboarding_2.png",
      title: "Consultez vos\ninformations",
      subtitle:
          "Retrouvez vos résultats, votre moyenne, votre emploi du temps et vos documents.",
    ),
    (
      image: "assets/images/onboarding_3.png",
      title: "Restez informé",
      subtitle:
          "Suivez les actualités et les événements officiels de l'Institut de Gestion et de Technologie.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OnboardingSkipButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RouteNames.login);
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        const Spacer(),

                        Image.asset(page.image, width: 190),

                        const SizedBox(height: 42),

                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                            height: 1.25,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          page.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 42),

                        OnboardingIndicator(
                          currentIndex: currentPage,
                          itemCount: pages.length,
                        ),

                        const Spacer(),

                        OnboardingButton(
                          text: currentPage == 2 ? "Commencer" : "Suivant",
                          onTap: () {
                            if (currentPage < 2) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.pushReplacementNamed(
                                context,
                                RouteNames.login,
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 28),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
