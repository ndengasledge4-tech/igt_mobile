import 'package:flutter/material.dart';

import '../../features/academie/pages/MesCours/cours_detail_page.dart';
import '../../features/academie/pages/MesCours/mes_cours_page.dart';
import '../../features/academie/pages/MesCours/semestre_page.dart';
import '../../features/academie/pages/MesDocuments/document_detail_page.dart';
import '../../features/academie/pages/MesDocuments/mes_documents_page.dart';
import '../../features/academie/pages/MesNotes/mes_notes_page.dart';
import '../../features/academie/pages/MesNotes/note_detail_page.dart';
import '../../features/academie/pages/MesResultats/mes_resultats_page.dart';
import '../../features/academie/pages/MesResultats/resultat_detail_page.dart';
import '../../features/timetable/timetable_page.dart';
import '../../features/academie/pages/MonParcours/mon_parcours_page.dart';
import '../../features/academie/pages/academie_page.dart';
import '../../features/accueil/pages/accueil_page.dart';
import '../../features/actualite/pages/actualites_page.dart';
import '../../features/actualite/pages/evenements_page.dart';
import '../../features/auth/activation/activation_screen.dart';
import '../../features/auth/create_password/create_password_screen.dart';
import '../../features/authentification/pages/forgot_password/mot_de_passe_oublie_page.dart';
import '../../features/authentification/pages/login/connexion_page.dart';
import '../../features/authentification/pages/onboarding/onboarding_page.dart';
import '../../features/authentification/pages/register/creation_compte_page.dart';
import '../../features/authentification/pages/reinitialisation/reinitialisation_page.dart';
import '../../features/authentification/pages/splash/splash_page.dart';
import '../../features/authentification/pages/waiting_validation/waiting_validation_page.dart';
import '../../features/messagerie/pages/messagerie_page.dart';
import '../../features/messagerie/pages/conversation_page.dart';
import '../../features/messagerie/pages/nouvelle_demande_page.dart';
import '../../features/teacher/teacher_home_page.dart';
import '../../features/mon_espace/pages/a_propos_page.dart';
import '../../features/mon_espace/pages/activite_recente_page.dart';
import '../../features/mon_espace/pages/aide_page.dart';
import '../../features/mon_espace/pages/historique_paiements_page.dart';
import '../../features/mon_espace/pages/informations_legales_page.dart';
import '../../features/mon_espace/pages/modifier_email_page.dart';
import '../../features/mon_espace/pages/modifier_mot_de_passe_page.dart';
import '../../features/mon_espace/pages/modifier_telephone_page.dart';
import '../../features/mon_espace/pages/mon_espace_page.dart';
import '../../features/mon_espace/pages/notifications_preferences_page.dart';
import '../../features/mon_espace/pages/parametres_page.dart';
import '../../features/mon_espace/pages/profil_page.dart';
import '../../features/mon_espace/pages/securite_compte_page.dart';
import '../../features/mon_espace/pages/sessions_actives_page.dart';
import '../../features/mon_espace/pages/situation_financiere_page.dart';
import '../../features/news/news_detail_screen.dart';
import '../../features/notifications/notifications_page.dart';
import '../../features/settings/settings_page.dart';
import '../../shared/navigation/navigation_page.dart';
import 'route_names.dart';

abstract final class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final page = _resolve(settings);
    return MaterialPageRoute<void>(builder: (_) => page, settings: settings);
  }

  static Widget _resolve(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return const SplashPage();
      case RouteNames.onboarding:
        return const OnboardingPage();
      case RouteNames.connexion:
      case RouteNames.login:
        return const ConnexionPage();
      case RouteNames.creationCompte:
        return const CreationComptePage();
      case RouteNames.motDePasseOublie:
      case RouteNames.forgotPassword:
        return const MotDePasseOubliePage();
      case RouteNames.reinitialisation:
        return const ReinitialisationPage();
      case RouteNames.waitingValidation:
        return const WaitingValidationPage();
      case RouteNames.activation:
        return const ActivationScreen();
      case RouteNames.createPassword:
        return const CreatePasswordScreen();

      case RouteNames.navigation:
      case RouteNames.dashboard:
        return const NavigationPage();
      case RouteNames.accueil:
        return const AccueilPage();

      case RouteNames.academie:
      case RouteNames.academic:
        return const AcademiePage();
      case RouteNames.monParcours:
        return const MonParcoursPage();
      case RouteNames.mesResultats:
      case RouteNames.results:
        return const MesResultatsPage();
      case RouteNames.resultatDetail:
        return const ResultatDetailPage();
      case RouteNames.emploiDuTemps:
      case RouteNames.timetable:
        return const TimetablePage();
      case RouteNames.mesCours:
        return const MesCoursPage();
      case RouteNames.semestre:
        final arguments = _arguments(settings);
        return SemestrePage(
          annee: arguments['annee'] as String? ?? '1ère année',
          semestres:
              (arguments['semestres'] as List?)?.whereType<String>().toList() ??
              const ['S1', 'S2'],
        );
      case RouteNames.coursDetail:
        return CoursDetailPage(
          semestre: settings.arguments is String
              ? settings.arguments! as String
              : 'S1',
        );
      case RouteNames.mesDocuments:
      case RouteNames.documents:
        return const MesDocumentsPage();
      case RouteNames.documentDetail:
        final arguments = _arguments(settings);
        return DocumentDetailPage(
          titre: arguments['titre'] as String? ?? 'Document IGT',
          type: arguments['type'] as String? ?? 'PDF',
          date: arguments['date'] as String? ?? 'Date indisponible',
          taille: arguments['taille'] as String? ?? 'Taille indisponible',
        );
      case RouteNames.mesNotes:
        return const MesNotesPage();
      case RouteNames.noteDetail:
        final arguments = _arguments(settings);
        return NoteDetailPage(
          titre: arguments['titre'] as String? ?? '1ère année',
          niveau: arguments['niveau'] as String? ?? 'Licence',
        );
      case RouteNames.subjectDetails:
        return const ResultatDetailPage();

      case RouteNames.actualite:
      case RouteNames.news:
        return const ActualitePage();
      case RouteNames.evenements:
      case RouteNames.events:
        return const EvenementsPage();
      case RouteNames.newsDetail:
        return const NewsDetailScreen();

      case RouteNames.messagerie:
        return const MessageriePage();
      case RouteNames.conversation:
        return ConversationPage(
          conversationId: settings.arguments is String
              ? settings.arguments! as String
              : 'teacher-mariam',
        );
      case RouteNames.nouvelleDemande:
        return const NouvelleDemandePage();
      case RouteNames.teacherHome:
        return const TeacherHomePage();

      case RouteNames.monEspace:
      case RouteNames.profile:
        return const MonEspacePage();
      case RouteNames.profil:
        return const ProfilPage();
      case RouteNames.situationFinanciere:
        return const SituationFinancierePage();
      case RouteNames.historiquePaiements:
        return const HistoriquePaiementsPage();
      case RouteNames.parametres:
        return const ParametresPage();
      case RouteNames.settings:
        return const SettingsPage();
      case RouteNames.modifierMotDePasse:
        return const ModifierMotDePassePage();
      case RouteNames.securiteCompte:
        return const SecuriteComptePage();
      case RouteNames.modifierTelephone:
        return const ModifierTelephonePage();
      case RouteNames.modifierEmail:
        return const ModifierEmailPage();
      case RouteNames.activiteRecente:
        return const ActiviteRecentePage();
      case RouteNames.notificationsPreferences:
        return const NotificationsPreferencesPage();
      case RouteNames.informationsLegales:
        return const InformationsLegalesPage();
      case RouteNames.sessionsActives:
        return const SessionsActivesPage();
      case RouteNames.aide:
        return const AidePage();
      case RouteNames.aPropos:
        return const AProposPage();
      case RouteNames.notifications:
        return const NotificationsPage();
      default:
        return const _NotFoundPage();
    }
  }

  static Map<String, Object?> _arguments(RouteSettings settings) {
    final arguments = settings.arguments;
    if (arguments is Map<String, Object?>) return arguments;
    return const {};
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page introuvable')),
      body: const Center(
        child: Text('404\nPage introuvable', textAlign: TextAlign.center),
      ),
    );
  }
}
