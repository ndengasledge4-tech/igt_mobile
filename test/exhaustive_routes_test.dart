import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/routes/route_generator.dart';
import 'package:igt/app/routes/route_names.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/app/theme/theme_mode_scope.dart';
import 'package:igt/features/academie/pages/MesCours/chapitre_page.dart';
import 'package:igt/features/academie/pages/MesCours/cours_contenu_page.dart';
import 'package:igt/features/academie/pages/MesCours/exercice_detail_page.dart';
import 'package:igt/features/academie/pages/MesCours/exercices_page.dart';
import 'package:igt/features/academie/pages/MesCours/videos_page.dart';
import 'package:igt/features/academie/pages/MesDocuments/mes_documents_page.dart';
import 'package:igt/features/accueil/pages/accueil_page.dart';
import 'package:igt/features/actualite/pages/evenement_detail_page.dart';
import 'package:igt/features/communication/communication_store.dart';
import 'package:igt/features/messagerie/pages/conversation_page.dart';
import 'package:igt/features/messagerie/pages/messagerie_page.dart';
import 'package:igt/features/mon_espace/pages/parametres_page.dart';
import 'package:igt/features/timetable/teacher_planning_page.dart';
import 'package:igt/shared/navigation/navigation_page.dart';

const _routes = <String>[
  RouteNames.splash,
  RouteNames.onboarding,
  RouteNames.connexion,
  RouteNames.creationCompte,
  RouteNames.motDePasseOublie,
  RouteNames.reinitialisation,
  RouteNames.waitingValidation,
  RouteNames.navigation,
  RouteNames.accueil,
  RouteNames.academie,
  RouteNames.mesCours,
  RouteNames.semestre,
  RouteNames.coursDetail,
  RouteNames.mesNotes,
  RouteNames.noteDetail,
  RouteNames.mesResultats,
  RouteNames.resultatDetail,
  RouteNames.emploiDuTemps,
  RouteNames.emploiDuTempsDetail,
  RouteNames.mesDocuments,
  RouteNames.documentDetail,
  RouteNames.monParcours,
  RouteNames.actualite,
  RouteNames.actualiteDetail,
  RouteNames.evenements,
  RouteNames.messagerie,
  RouteNames.conversation,
  RouteNames.nouvelleDemande,
  RouteNames.teacherHome,
  RouteNames.monEspace,
  RouteNames.profil,
  RouteNames.situationFinanciere,
  RouteNames.historiquePaiements,
  RouteNames.parametres,
  RouteNames.modifierMotDePasse,
  RouteNames.securiteCompte,
  RouteNames.modifierTelephone,
  RouteNames.modifierEmail,
  RouteNames.activiteRecente,
  RouteNames.notificationsPreferences,
  RouteNames.informationsLegales,
  RouteNames.sessionsActives,
  RouteNames.aide,
  RouteNames.aPropos,
  RouteNames.notifications,
  RouteNames.activation,
  RouteNames.login,
  RouteNames.createPassword,
  RouteNames.forgotPassword,
  RouteNames.dashboard,
  RouteNames.news,
  RouteNames.newsDetail,
  RouteNames.events,
  RouteNames.academic,
  RouteNames.timetable,
  RouteNames.results,
  RouteNames.subjectDetails,
  RouteNames.documents,
  RouteNames.profile,
  RouteNames.settings,
];

const _viewports = <(Size, ThemeMode)>[
  (Size(320, 760), ThemeMode.light),
  (Size(320, 760), ThemeMode.dark),
  (Size(390, 844), ThemeMode.light),
  (Size(390, 844), ThemeMode.dark),
  (Size(480, 900), ThemeMode.light),
  (Size(480, 900), ThemeMode.dark),
  (Size(800, 1100), ThemeMode.light),
  (Size(800, 1100), ThemeMode.dark),
];

void main() {
  setUp(CommunicationStore.instance.resetDemo);

  testWidgets('every declared route renders across themes and breakpoints', (
    tester,
  ) async {
    final notifier = AppThemeModeNotifier(ThemeMode.light);
    addTearDown(notifier.dispose);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1;
    final failures = <String>[];

    for (final viewport in _viewports) {
      tester.view.physicalSize = viewport.$1;
      notifier.value = viewport.$2;
      for (final route in _routes) {
        await tester.pumpWidget(
          AppThemeModeScope(
            notifier: notifier,
            child: MaterialApp(
              key: ValueKey('${viewport.$1.width}-${viewport.$2}-$route'),
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: viewport.$2,
              initialRoute: route,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 50));
        final exception = tester.takeException();
        if (exception != null) {
          failures.add(
            '$route @ ${viewport.$1.width}px/${viewport.$2.name}: $exception',
          );
        }
      }
    }
    expect(failures, isEmpty, reason: failures.join('\n'));
  });

  testWidgets('directly pushed screen variants render across the same matrix', (
    tester,
  ) async {
    final store = CommunicationStore.instance;
    final variants = <(String, Widget Function())>[
      (
        'course-content',
        () => const CoursContenuPage(
          imagePath: '',
          nom: 'Architecture logicielle',
          professeur: 'Pr. Mariam Diarra',
          semestre: 'S5',
          credits: 4,
          coefficient: 2,
        ),
      ),
      (
        'chapter',
        () => const ChapitrePage(
          titre: 'Architecture en couches',
          numero: '02',
          contenu: 'Contenu de démonstration du chapitre.',
          objectifs: ['Comprendre', 'Appliquer', 'Vérifier'],
        ),
      ),
      ('videos', () => const VideosPage()),
      ('exercises', () => const ExercicesPage()),
      (
        'exercise-detail',
        () => const ExerciceDetailPage(
          numero: '01',
          titre: 'Quiz de compréhension',
          description: 'Vérifier les acquis du chapitre.',
          niveau: 'Facile',
        ),
      ),
      ('event-detail', () => EvenementDetailPage(event: store.events.first)),
      ('teacher-planning', () => const TeacherPlanningPage()),
      ('teacher-messaging', () => const MessageriePage(teacherMode: true)),
      (
        'group-conversation',
        () => const ConversationPage(conversationId: 'group-l3'),
      ),
      (
        'assistant-conversation',
        () => const ConversationPage(conversationId: 'igt-ai'),
      ),
      ('embedded-documents', () => const MesDocumentsPage(embedded: true)),
      ('embedded-home', () => const AccueilPage()),
      ('application-shell', () => const NavigationPage()),
    ];
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1;
    final failures = <String>[];

    for (final viewport in _viewports) {
      tester.view.physicalSize = viewport.$1;
      for (final variant in variants) {
        await tester.pumpWidget(
          MaterialApp(
            key: ValueKey('${viewport.$1.width}-${viewport.$2}-${variant.$1}'),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: viewport.$2,
            home: variant.$2(),
          ),
        );
        await tester.pump(const Duration(milliseconds: 50));
        final exception = tester.takeException();
        if (exception != null) {
          failures.add(
            '${variant.$1} @ ${viewport.$1.width}px/${viewport.$2.name}: $exception',
          );
        }
      }
    }
    expect(failures, isEmpty, reason: failures.join('\n'));
  });

  testWidgets('legacy aliases resolve to canonical screens', (tester) async {
    final notifier = AppThemeModeNotifier(ThemeMode.light);
    addTearDown(notifier.dispose);

    await tester.pumpWidget(
      AppThemeModeScope(
        notifier: notifier,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          initialRoute: RouteNames.settings,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
    expect(find.byType(ParametresPage), findsOneWidget);

    await tester.pumpWidget(
      AppThemeModeScope(
        notifier: notifier,
        child: MaterialApp(
          key: UniqueKey(),
          theme: AppTheme.lightTheme,
          initialRoute: RouteNames.dashboard,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
    expect(find.byType(NavigationPage), findsOneWidget);
  });
}
