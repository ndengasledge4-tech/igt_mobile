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

<<<<<<< HEAD
import '../../features/academic/academic_screen.dart';
import '../../features/timetable/timetable_page.dart';
import '../../features/results/results_page.dart';
import '../../features/results/subject_details_screen.dart';
import '../../features/documents/documents_page.dart';
=======
// ============================================================
// ACADEMIE
// ============================================================
import '../../features/Academie/pages/academie_page.dart';
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93

// ============================================================
// PARCOURS
// ============================================================
import '../../features/academie/pages/MonParcours/mon_parcours_page.dart';

// ============================================================
// MES RESULTATS
// ============================================================

import '../../features/academie/pages/MesResultats/mes_resultats_page.dart';

// ============================================================
// MON EMPLOI DU TEMPS
// ============================================================

import '../../features/academie/pages/MonEmploiDuTemps/emploi_du_temps_page.dart';

// ============================================================
// MES COURS
// ============================================================
import '../../features/academie/pages/MesCours/mes_cours_page.dart';
import '../../features/academie/pages/MesCours/semestre_page.dart';
import '../../features/academie/pages/MesCours/cours_detail_page.dart';

// ============================================================
// MES DOCUMENTS
// ============================================================
import '../../features/academie/pages/MesDocuments/mes_documents_page.dart';
import '../../features/academie/pages/MesDocuments/document_detail_page.dart';

// ============================================================
// MES NOTES
// ============================================================
import '../../features/academie/pages/MesNotes/mes_notes_page.dart';
import '../../features/academie/pages/MesNotes/note_detail_page.dart';

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
      // ========================================================
      // AUTHENTIFICATION
      // ========================================================

      case RouteNames.splash:
<<<<<<< HEAD
        return _page(const SplashPage());

      case RouteNames.onboarding:
        return _page(const OnboardingPage());

      case RouteNames.activation:
        return _page(const ActivationScreen(), settings);

      case RouteNames.login:
        return _page(const LoginPage());

      case RouteNames.createPassword:
        return _page(const CreatePasswordScreen(), settings);

      case RouteNames.forgotPassword:
        return _page(const ForgotPasswordPage());

      case RouteNames.dashboard:
        return _page(const DashboardPage());

      case RouteNames.news:
        return _page(const NewsPage());

      case RouteNames.newsDetail:
        return _page(const NewsDetailScreen());

      case RouteNames.events:
        return _page(const EventsPage());

      case RouteNames.academic:
        return _page(const AcademicScreen(), settings);

      case RouteNames.timetable:
        return _page(const TimetablePage());
=======
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );

      case RouteNames.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
          settings: settings,
        );
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93

      case RouteNames.connexion:
        return MaterialPageRoute(
          builder: (_) => const ConnexionPage(),
          settings: settings,
        );

<<<<<<< HEAD
      case RouteNames.subjectDetails:
        return _page(const SubjectDetailsScreen(), settings);

      case RouteNames.documents:
        return _page(const DocumentsPage());
=======
      case RouteNames.creationCompte:
        return MaterialPageRoute(
          builder: (_) => const CreationComptePage(),
          settings: settings,
        );
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93

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
<<<<<<< HEAD
        return _page(const NavigationScreen(), settings);

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404\nPage introuvable', textAlign: TextAlign.center),
            ),
=======
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
      // MON PARCOURS
      // ============================================================
      case RouteNames.monParcours:
        return _page(const MonParcoursPage());

      // ============================================================
      // MES RÉSULTATS
      // ============================================================

      case RouteNames.mesResultats:
        return _page(const MesResultatsPage());

      // ============================================================
      // MON EMPLOI DU TEMPS
      // ============================================================
      case RouteNames.emploiDuTemps:
        return _page(const EmploiDuTempsPage());

      // ============================================================
      // MES COURS
      // ============================================================
      case RouteNames.mesCours:
        return _page(const MesCoursPage());

      // ============================================================
      // SEMESTRE
      // ============================================================
      case RouteNames.semestre:
        final arguments = settings.arguments as Map<String, dynamic>;

        return _page(
          SemestrePage(
            annee: arguments['annee'],
            semestres: arguments['semestres'],
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
          ),
        );

      // ============================================================
      // DÉTAIL DU COURS
      // ============================================================
      case RouteNames.coursDetail:
        final semestre = settings.arguments as String;

        return _page(CoursDetailPage(semestre: semestre));

      // ============================================================
      // MES DOCUMENTS
      // ============================================================
      case RouteNames.mesDocuments:
        return _page(const MesDocumentsPage());

      // ============================================================
      // DÉTAIL DU DOCUMENT
      // ============================================================
      case RouteNames.documentDetail:
        final arguments = settings.arguments as Map<String, dynamic>;

        return _page(
          DocumentDetailPage(
            titre: arguments['titre'],
            type: arguments['type'],
            date: arguments['date'],
            taille: arguments['taille'],
          ),
        );

      // ============================================================
      // MES NOTES
      // ============================================================
      case RouteNames.mesNotes:
        return _page(const MesNotesPage());

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

<<<<<<< HEAD
  static MaterialPageRoute _page(Widget page, [RouteSettings? settings]) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
=======
  static MaterialPageRoute _page(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
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
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
  }
}
