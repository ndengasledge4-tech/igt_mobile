import 'package:flutter/material.dart';

// ============================================================
// AUTHENTIFICATION
// ============================================================
import '../../features/Authentification/pages/splash_page.dart';
import '../../features/Authentification/pages/onboarding_page.dart';
import '../../features/Authentification/pages/connexion_page.dart';
import '../../features/Authentification/pages/creation_compte_page.dart';
import '../../features/Authentification/pages/mot_de_passe_oublie_page.dart';
import '../../features/Authentification/pages/reinitialisation_page.dart';

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

  static Route<dynamic> generateRoute(
      RouteSettings settings,
      ) {
    switch (settings.name) {
    // ========================================================
    // AUTHENTIFICATION
    // ========================================================

      case RouteNames.splash:
        return _page(
          const SplashPage(),
        );

      case RouteNames.onboarding:
        return _page(
          const OnboardingPage(),
        );

      case RouteNames.connexion:
        return _page(
          const ConnexionPage(),
        );

      case RouteNames.creationCompte:
        return _page(
          const CreationComptePage(),
        );

      case RouteNames.motDePasseOublie:
        return _page(
          const MotDePasseOubliePage(),
        );

      case RouteNames.reinitialisation:
        return _page(
          const ReinitialisationPage(),
        );

    // ========================================================
    // NAVIGATION PRINCIPALE
    // ========================================================

      case RouteNames.navigation:
        return _page(
          const NavigationPage(),
        );

    // ============================================================
    // ACCUEIL
    // ============================================================

      case RouteNames.accueil:
        return _page(
          const AccueilPage(),
        );


    // ============================================================
    // ACADEMIE
    // ============================================================
      case RouteNames.academie:
        return _page(
          const AcademiePage(),
        );


    // ============================================================
    // ACTUALITE
    // ============================================================
      case RouteNames.actualite:
        return _page(
          const ActualitePage(),
        );


    // ============================================================
    // MESSAGERIE
    // ============================================================
      case RouteNames.messagerie:
        return _page(
          const MessageriePage(),
        );


    // ============================================================
    // MON ESPACE
    // ============================================================
      case RouteNames.monEspace:
        return _page(
          const MonEspacePage(),
        );

    // ========================================================
    // ROUTE INCONNUE
    // ========================================================

      default:
        return _notFound();
    }
  }

  static MaterialPageRoute _page(
      Widget page,
      ) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }

  static MaterialPageRoute _notFound() {
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