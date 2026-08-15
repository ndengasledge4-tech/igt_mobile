import 'package:flutter/material.dart';

// ============================================================
// AUTHENTIFICATION
// ============================================================
import '../../features/Authentification/pages/forgot_password/mot_de_passe_oublie_page.dart';
import '../../features/Authentification/pages/login/connexion_page.dart';
import '../../features/Authentification/pages/onboarding/onboarding_page.dart';
import '../../features/Authentification/pages/reinitialisation/reinitialisation_page.dart';
import '../../features/Authentification/pages/register/creation_compte_page.dart';
import '../../features/Authentification/pages/splash/splash_page.dart';
import '../../features/Authentification/pages/waiting_validation/waiting_validation_page.dart';

// ============================================================
// NAVIGATION PRINCIPALE
// ============================================================
import '../../shared/navigation/navigation_page.dart';

// ============================================================
// ACCUEIL
// ============================================================
import '../../features/Accueil/pages/accueil_page.dart';

// ============================================================
// ACADEMIE
// ============================================================
import '../../features/Academie/pages/academie_page.dart';


// ============================================================
// ACTUALITE
// ============================================================
import '../../features/Actualite/pages/actualites_page.dart';

// ============================================================
// MESSAGERIE
// ============================================================
import '../../features/Messagerie/pages/messagerie_page.dart';

// ============================================================
// MON ESPACE
// ============================================================
import '../../features/mon_espace/pages/mon_espace_page.dart';

import 'route_names.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ========================================================
      // AUTHENTIFICATION
      // ========================================================

      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );

      case RouteNames.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
          settings: settings,
        );

      case RouteNames.connexion:
        return MaterialPageRoute(
          builder: (_) => const ConnexionPage(),
          settings: settings,
        );

      case RouteNames.creationCompte:
        return MaterialPageRoute(
          builder: (_) => const CreationComptePage(),
          settings: settings,
        );

      case RouteNames.motDePasseOublie:
        return MaterialPageRoute(
          builder: (_) => const MotDePasseOubliePage(),
          settings: settings,
        );

      case RouteNames.reinitialisation:
        return MaterialPageRoute(
          builder: (_) => const ReinitialisationPage(),
          settings: settings,
        );

      case RouteNames.waitingValidation:
        return MaterialPageRoute(
          builder: (_) => const WaitingValidationPage(),
          settings: settings,
        );

      // ========================================================
      // NAVIGATION PRINCIPALE
      // ========================================================

      case RouteNames.navigation:
        return _page(const NavigationPage());

      // ============================================================
      // ACCUEIL
      // ============================================================

      case RouteNames.accueil:
        return _page(const AccueilPage());

      // ============================================================
      // ACADEMIE
      // ============================================================
      case RouteNames.academie:
        return _page(const AcademiePage());

      // ============================================================
      // ACTUALITE
      // ============================================================
      case RouteNames.actualite:
        return _page(const ActualitePage());

      // ============================================================
      // MESSAGERIE
      // ============================================================
      case RouteNames.messagerie:
        return _page(const MessageriePage());

      // ============================================================
      // MON ESPACE
      // ============================================================
      case RouteNames.monEspace:
        return _page(const MonEspacePage());

      // ========================================================
      // ROUTE INCONNUE
      // ========================================================

      default:
        return _notFound();
    }
  }

  static MaterialPageRoute _page(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static MaterialPageRoute _notFound() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('404\nPage introuvable', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
