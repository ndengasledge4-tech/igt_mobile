import 'package:flutter/material.dart';

import '../../features/authentification/pages/forgot_password/mot_de_passe_oublie_page.dart';
import '../../features/authentification/pages/login/connexion_page.dart';
import '../../features/authentification/pages/onboarding/onboarding_page.dart';
import '../../features/authentification/pages/reinitialisation/reinitialisation_page.dart';
import '../../features/authentification/pages/register/creation_compte_page.dart';
import '../../features/authentification/pages/splash/splash_page.dart';
import '../../features/authentification/pages/waiting_validation/waiting_validation_page.dart';
import '../../shared/navigation/navigation_page.dart';
import '../../features/accueil/pages/accueil_page.dart';
import '../../features/academie/pages/academie_page.dart';
import '../../features/actualite/pages/actualites_page.dart';
import '../../features/messagerie/pages/messagerie_page.dart';
import '../../features/mon_espace/pages/mon_espace_page.dart';
import '../../features/mon_espace/pages/profil_page.dart';
import '../../features/mon_espace/pages/situation_financiere_page.dart';
import '../../features/mon_espace/pages/historique_paiements_page.dart';
import '../../features/mon_espace/pages/parametres_page.dart';
import '../../features/mon_espace/pages/modifier_mot_de_passe_page.dart';
import '../../features/mon_espace/pages/securite_compte_page.dart';
import '../../features/mon_espace/pages/modifier_telephone_page.dart';
import '../../features/mon_espace/pages/modifier_email_page.dart';
import '../../features/mon_espace/pages/activite_recente_page.dart';
import '../../features/mon_espace/pages/notifications_preferences_page.dart';
import '../../features/mon_espace/pages/informations_legales_page.dart';
import '../../features/mon_espace/pages/sessions_actives_page.dart';

import 'route_names.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash: return _page(const SplashPage(), settings);
      case RouteNames.onboarding: return _page(const OnboardingPage(), settings);
      case RouteNames.connexion: return _page(const ConnexionPage(), settings);
      case RouteNames.creationCompte: return _page(const CreationComptePage(), settings);
      case RouteNames.motDePasseOublie: return _page(const MotDePasseOubliePage(), settings);
      case RouteNames.reinitialisation: return _page(const ReinitialisationPage(), settings);
      case RouteNames.waitingValidation: return _page(const WaitingValidationPage(), settings);
      case RouteNames.navigation: return _page(const NavigationPage(), settings);
      case RouteNames.accueil: return _page(const AccueilPage(), settings);
      case RouteNames.academie: return _page(const AcademiePage(), settings);
      case RouteNames.actualite: return _page(const ActualitePage(), settings);
      case RouteNames.messagerie: return _page(const MessageriePage(), settings);
      case RouteNames.monEspace: return _page(const MonEspacePage(), settings);
      case RouteNames.profil: return _page(const ProfilPage(), settings);
      case RouteNames.situationFinanciere: return _page(const SituationFinancierePage(), settings);
      case RouteNames.historiquePaiements: return _page(const HistoriquePaiementsPage(), settings);
      case RouteNames.parametres: return _page(const ParametresPage(), settings);
      case RouteNames.modifierMotDePasse: return _page(const ModifierMotDePassePage(), settings);
      case RouteNames.securiteCompte: return _page(const SecuriteComptePage(), settings);
      case RouteNames.modifierTelephone: return _page(const ModifierTelephonePage(), settings);
      case RouteNames.modifierEmail: return _page(const ModifierEmailPage(), settings);
      case RouteNames.activiteRecente: return _page(const ActiviteRecentePage(), settings);
      case RouteNames.notificationsPreferences: return _page(const NotificationsPreferencesPage(), settings);
      case RouteNames.informationsLegales: return _page(const InformationsLegalesPage(), settings);
      case RouteNames.sessionsActives: return _page(const SessionsActivesPage(), settings);
      default: return _notFound();
    }
  }

  static MaterialPageRoute _page(Widget page, RouteSettings settings) => MaterialPageRoute(
    builder: (_) => page,
    settings: settings,
  );

  static MaterialPageRoute _notFound() => MaterialPageRoute(
    builder: (_) => const Scaffold(body: Center(child: Text('404\nPage introuvable', textAlign: TextAlign.center))),
  );
}
