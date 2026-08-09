import 'package:flutter/material.dart';

/* authentification */

import '../../features/authentification/pages/register/register_screen.dart';
import '../../features/authentification/pages/waiting_validation/waiting_validation_screen.dart';
import '../../features/authentification/pages/forgot_password/forgot_password_page.dart';
import '../../features/authentification/pages/login/login_page.dart';
import '../../features/authentification/pages/onboarding/onboarding_page.dart';
import '../../features/authentification/pages/splash/splash_page.dart';

/*  navigation */

import '../../shared/navigation/navigation_screen.dart';



import 'route_names.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      /* authentification */

      case RouteNames.splash: return _page(const SplashPage());
      case RouteNames.onboarding: return _page(const OnboardingPage());
      case RouteNames.login: return _page(const LoginPage());
      case RouteNames.register: return _page(const RegisterScreen());
      case RouteNames.waitingValidation: return _page(const WaitingValidationScreen());
      case RouteNames.forgotPassword: return _page(const ForgotPasswordPage());


      /* navigation */

      case RouteNames.navigation: return MaterialPageRoute(
          builder: (_) => const NavigationScreen(),
        );



      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                '404\nPage introuvable',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _page(Widget page) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }
}