import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/features/academie/pages/MesCours/cours_contenu_page.dart';
import 'package:igt/features/academie/pages/MesCours/exercice_detail_page.dart';
import 'package:igt/features/academie/pages/MesCours/mes_cours_page.dart';
import 'package:igt/features/academie/pages/MesCours/videos_page.dart';
import 'package:igt/features/academie/pages/MesDocuments/document_detail_page.dart';
import 'package:igt/features/academie/pages/MesResultats/mes_resultats_page.dart';

Widget _app(Widget home, {ThemeMode mode = ThemeMode.light}) => MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: mode,
  home: home,
);

void main() {
  testWidgets('courses support search and open the canonical course detail', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const MesCoursPage()));
    await tester.enterText(find.byKey(const Key('course-search')), 'mobile');
    await tester.pump();
    expect(find.text('Développement mobile'), findsOneWidget);
    expect(find.text('Architecture logicielle'), findsNothing);
    await tester.tap(find.text('Développement mobile'));
    await tester.pumpAndSettle();
    expect(find.byType(CoursContenuPage), findsOneWidget);
    expect(find.text('Chapitres'), findsOneWidget);
  });

  testWidgets('mock video and exercise interactions are available', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const VideosPage()));
    await tester.tap(find.text('Patrons de conception'));
    await tester.pump();
    expect(find.byKey(const Key('mock-video-player')), findsOneWidget);

    await tester.pumpWidget(
      _app(
        const ExerciceDetailPage(
          numero: '01',
          titre: 'Quiz',
          description: 'Vérifier les acquis',
          niveau: 'Facile',
        ),
      ),
    );
    await tester.tap(find.byKey(const Key('start-exercise')));
    await tester.pump();
    expect(find.text('Votre réponse mock'), findsOneWidget);
  });

  testWidgets('results remain readable in dark tablet layout', (tester) async {
    tester.view.physicalSize = const Size(1024, 1366);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      _app(const MesResultatsPage(), mode: ThemeMode.dark),
    );
    expect(find.text('Résultats par matière'), findsOneWidget);
    expect(find.textContaining('13,7', findRichText: true), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('document download transitions to downloaded', (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      _app(
        const DocumentDetailPage(
          titre: 'Calendrier académique',
          type: 'PDF',
          date: '25/08/2026',
          taille: '1,2 Mo',
        ),
      ),
    );
    await tester.ensureVisible(
      find.byKey(const Key('document-download-button')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('document-download-button')));
    await tester.pump();
    expect(find.textContaining('Téléchargement'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Téléchargé'), findsOneWidget);
  });
}
