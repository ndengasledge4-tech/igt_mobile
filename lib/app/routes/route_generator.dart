import 'package:flutter/material.dart';

// ============================================================
// AUTHENTIFICATION
// ============================================================
import '../../features/authentification/pages/forgot_password/mot_de_passe_oublie_page.dart';
import '../../features/authentification/pages/login/connexion_page.dart';
import '../../features/authentification/pages/onboarding/onboarding_page.dart';
import '../../features/authentification/pages/reinitialisation/reinitialisation_page.dart';
import '../../features/authentification/pages/register/creation_compte_page.dart';
import '../../features/authentification/pages/splash/splash_page.dart';
import '../../features/authentification/pages/waiting_validation/waiting_validation_page.dart';

// ============================================================
// NAVIGATION PRINCIPALE
// ============================================================
import '../../shared/navigation/navigation_page.dart';

// ============================================================
// ACCUEIL
// ============================================================
import '../../features/accueil/pages/accueil_page.dart';

// ============================================================
// ACADEMIE
// ============================================================
import '../../features/academie/pages/academie_page.dart';

// ============================================================
// ACTUALITE
// ============================================================
import '../../features/actualite/pages/actualites_page.dart';

// ============================================================
// MESSAGERIE
// ============================================================
import '../../features/messagerie/pages/messagerie_page.dart';

// ============================================================
// MON ESPACE
// ============================================================
import '../../features/mon_espace/pages/mon_espace_page.dart';
import '../../features/mon_espace/pages/profil_page.dart';
import '../../features/mon_espace/pages/situation_financiere_page.dart';
import '../../features/mon_espace/pages/historique_paiements_page.dart';
import '../../features/mon_espace/pages/parametres_page.dart';
import '../../features/mon_espace/pages/modifier_mot_de_passe_page.dart';
import '../../features/mon_espace/pages/a_propos_page.dart';
import '../../features/mon_espace/pages/aide_page.dart';

import 'route_names.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // AUTHENTIFICATION
      case RouteNames.splash:
        return _page(const SplashPage());
      case RouteNames.onboarding:
        return _page(const OnboardingPage());
      case RouteNames.connexion:
        return _page(const ConnexionPage());
      case RouteNames.creationCompte:
        return _page(const CreationComptePage());
      case RouteNames.motDePasseOublie:
        return _page(const MotDePasseOubliePage());
      case RouteNames.reinitialisation:
        return _page(const ReinitialisationPage());
      case RouteNames.waitingValidation:
        return _page(const WaitingValidationPage());

      // NAVIGATION PRINCIPALE
      case RouteNames.navigation:
        return _page(const NavigationPage());

      // ACCUEIL
      case RouteNames.accueil:
        return _page(const AccueilPage());

      // ACADEMIE
      case RouteNames.academie:
        return _page(const AcademiePage());

      // ACTUALITE
      case RouteNames.actualite:
        return _page(const ActualitePage());

      // MESSAGERIE
      case RouteNames.messagerie:
        return _page(const MessageriePage());

      // MON ESPACE
      case RouteNames.monEspace:
        return _page(const MonEspacePage());
      case RouteNames.profil:
        return _page(const ProfilPage());
      case RouteNames.situationFinanciere:
        return _page(const SituationFinancierePage());
      case RouteNames.historiquePaiements:
        return _page(const HistoriquePaiementsPage());
      case RouteNames.parametres:
        return _page(const ParametresPage());
      case RouteNames.modifierMotDePasse:
        return _page(const ModifierMotDePassePage());

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
        body: Center(child: Text('404\nPage introuvable', textAlign: TextAlign.center)),
      ),
    );
  }
}
